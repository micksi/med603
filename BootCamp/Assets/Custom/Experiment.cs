using UnityEngine;
using System;
using System.IO;
using System.Collections.Generic;
using ThresholdFinding;

namespace TestFramework
{
	public class Experiment : AbstractExperiment
	{
		public readonly string Name;
		public readonly TestFramework Framework;
		public readonly ThresholdFinderComponent TFC;
		private bool begun = false;
		private List<Participant> participants;

		public string FolderPath
		{
			get
			{
				return Path.Combine(Framework.ExperimentsFolderPath, Name);
			}
		}

		public string ParticipantsFolderPath
		{
			get
			{
				return Path.Combine(FolderPath, "Participants");
			}
		}

		public Experiment(string name, TestFramework framework, ThresholdFinderComponent tfc)
		{
			this.Name = name;
			this.Framework = framework;
			this.TFC = tfc;
			Initialize();
		}

		private void Initialize()
		{
			if(Directory.Exists(FolderPath) == false)
			{
				Directory.CreateDirectory(FolderPath);
				Debug.Log(FolderPath + " created");
			}
			if(Directory.Exists(ParticipantsFolderPath) == false)
			{
				Directory.CreateDirectory(ParticipantsFolderPath);
				Debug.Log(ParticipantsFolderPath + " created");
			}

			// Get number of participants from directory
			string[] subdirs = Directory.GetDirectories(ParticipantsFolderPath);
			participants = new List<Participant>(subdirs.Length + 1);

			for(int i = 0; i < subdirs.Length; i++)
			{
				participants.Add(new Participant(this, Path.GetFileName(subdirs[i])));
			}

			TFC.Finder.FinishedEvent += OnFinderFinished;
		}

		public override void Begin()
		{
			NewParticipant();
			begun = true;
		}

		private void OnFinderFinished(object sender, FinishedEventArgs args)
		{
			args.Finder.SaveObservationsToDisk(ActiveParticipant.FolderPath);
		}

		public Participant ActiveParticipant
		{
			get
			{
				if(begun == false)
					throw new InvalidOperationException("Experiment not begun yet");
				return participants[participants.Count - 1];
			}
		}

		public override Participant NewParticipant()
		{
			uint newId = 1;
			if(participants.Count > 0)
			{
				Participant last = participants[participants.Count - 1];
				newId = last.Id + 1;
			}
			Debug.Log("New participant with id " + newId);
			Participant p = new Participant(this, newId.ToString("0000"));
			participants.Add(p);
			return p;
		}
	}
}
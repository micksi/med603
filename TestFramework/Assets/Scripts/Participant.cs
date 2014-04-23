using UnityEngine;
using System;
using System.IO;

namespace TestFramework
{
	public class Participant
	{

		private readonly Experiment experiment;
		private readonly string folderName;

		internal Participant(Experiment experiment, string folderName)
		{
			this.experiment = experiment;
			this.folderName = folderName;
			Initialize();
		}

		private void Initialize()
		{
			if(Directory.Exists(FolderPath) == false)
			{
				Directory.CreateDirectory(FolderPath);
				Debug.Log(FolderPath + " was created");
			}
		}

		public uint Id
		{
			get
			{
				try
				{
					return Convert.ToUInt32(folderName);
				}
				catch(FormatException e)
				{
					throw new FormatException(folderName + " is not in the correct format");
				}
			}
		}

		public string FolderPath
		{
			get
			{
				return Path.Combine(experiment.ParticipantsFolderPath, folderName);
			}
		}

	}
}
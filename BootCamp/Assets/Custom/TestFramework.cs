using UnityEngine;
using System;
using System.IO;

namespace TestFramework
{
	public class TestFramework : MonoBehaviour
	{

		public AbstractExperiment experiment;
		public ThresholdFinderComponent thresholdFinderComponent;

		public void Awake()
		{
			Initialize();
		}

		public void Update()
		{
			if(Input.GetKeyDown("a"))
			{
				experiment.NewParticipant();
			}
		}

		public void Initialize()
		{
			// Create dir
			if(Directory.Exists(ExperimentsFolderPath))
			{
				Debug.Log(ExperimentsFolderPath + " already exists");
			}
			else
			{
				Directory.CreateDirectory(ExperimentsFolderPath);
				Debug.Log(ExperimentsFolderPath + "was created");
			}
			// Initialize experiment

			experiment = new Experiment("CSF Test", this, thresholdFinderComponent);
			experiment.Begin();
		}

		public string ExperimentsFolderPath
		{
			get
			{
				string appFolder = Application.dataPath;
				string unityFolder = Path.Combine(appFolder, "../");
				string experimentsFolder = Path.Combine(unityFolder, "Experiments");
				return experimentsFolder;
			}
		}

	}	


}
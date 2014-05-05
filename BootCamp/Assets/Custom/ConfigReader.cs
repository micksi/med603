using UnityEngine;
using System.Collections;

// Use: string value = ConfigReader.GetValueOf(key);
public static class ConfigReader {

	private static readonly string path = "config.txt";
	private static readonly string delimiter = "=";
	private static string config = ((TextAsset)Resources.Load("config", typeof(TextAsset))).text;


	public static string GetValueOf(string key)
	{
		string line;
		using(System.IO.StringReader file = new System.IO.StringReader(config))
		{
			while((line = file.ReadLine()) != null)
			{
				if(line.Contains(key))
				{
					line = line.Substring(line.IndexOf(delimiter) + 1);
					break;
				}
			}
		}

		//Debug.Log("Looked for " + key + " found " + line);

		return line;
	}

}

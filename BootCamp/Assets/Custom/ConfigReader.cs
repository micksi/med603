using UnityEngine;
using System.Collections;
using System.IO;
using System;

// Use: string value = ConfigReader.GetValueOf(key);
public static class ConfigReader {

	private static readonly string filename = "config.txt";
	private static readonly string delimiter = "=";
	private static string contents = "";

	public static string GetValueOf(string key)
	{
		if(contents.Length == 0)
		{
			string path = Application.dataPath; // Data folder, or Assets folder
			
			if(Application.isEditor == false) // We're in a build
			{
				path = Path.GetDirectoryName(path); // cd ..
				path = Path.GetDirectoryName(path); // cd ..
			}
			
			path = Path.Combine(path, filename);
			Debug.Log("Gonna read config from " + path);

			using(StreamReader file = new StreamReader(path))
			{
				contents = file.ReadToEnd();
			}
		}

		string line;
		using(StringReader file = new StringReader(contents))
		{
			bool found = false;
			while((line = file.ReadLine()) != null)
			{
				if(line.Contains(key))
				{
					line = line.Substring(line.IndexOf(delimiter) + 1);
					found = true;
                    Debug.Log("Config: Found " + key + " with value " + line);
					break;
				}
			}

			if(found == false)
			{
				throw new InvalidOperationException("Couldn't find key '" + key + "' in config!");
			}
		}

		//Debug.Log("Looked for " + key + " found " + line);

		return line;
	}

}

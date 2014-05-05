using UnityEngine;
using System.Collections;

public static class ConfigReader {

	private static readonly string path = "ourconfig.txt";
	private static readonly string delimiter = "=";


	public static string GetValueOf(string key)
	{
		string line;
		using(System.IO.StreamReader file = new System.IO.StreamReader(Application.dataPath + "/" + path))
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

		return line;
	}

}

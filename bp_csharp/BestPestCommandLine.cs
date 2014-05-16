using System;
using System.Collections.Generic;
using System.IO;
using ThresholdFinding;

// Test (windows):
//  make build;mono .\BestPestCommandLine.exe .\testdata.csv | % {$_ + ",1"} | out-file -append .\testdata.csv -enc utf8
//
// Test on all testdata (windows):
//  ls .\testdata\*0* -rec -excl *gazelog* | % {mono bin/BestPestCommandLine.exe $_}
//
// Test on all testdata (unix):
//  make build; find testdata -name "*.csv" -not -name "*gazelog*" -not -path "*OUTPUT*" -not -name "*demographic*" | xargs -ifile mono bin/BestPestCommandLine.exe file
//
// Apply to all csv files (windows powershell)
//  ls .\testdata\0002 -rec -excl *gazelog* | % {add-content $_ $($(mono bin/BestPestCommandLine.exe $_) + ",0")}

public class BestPestCommandLine
{

	public static void Main(string[] args)
	{
		if(args.Length == 0 || String.IsNullOrEmpty(args[0]) || args[0] == "--help")
		{
			Console.WriteLine("Supply filepath and [delimiter]");
			return;
		}

		string del =  ",";
		if(args.Length > 1 && String.IsNullOrEmpty(args[1]) == false)
			del = args[1];
		string filename = args[0].Replace("/ ", " ");
		// Console.WriteLine(filename);
		// return;

		Range range = new Range(0, 140, 1000);
		double B = 2.0;

		CSVReader reader = new CSVReader(del, new string[]{"Stimulus", "Value"});
		Dictionary<string, List<String>> result = reader.Read(filename);

		List<KeyValuePair<double, bool>> samples = new List<KeyValuePair<double, bool>>();

		int i = 0;
		foreach(var stim in result["Stimulus"])
		{
			double stimDouble = Convert.ToDouble(stim);
			string valString = result["Value"][i];
			bool val = false;
			if(valString == "1")
				val = true;
			else if(valString == "-1")
				val = false;
			else
				throw new InvalidOperationException("1 or -1 not encountered");

			samples.Add(new KeyValuePair<double, bool>(stimDouble, val));
			i++;
		}

		double threshold = BestPest.CalculateStimulus(range, samples, B);
		Console.WriteLine(threshold);
	}

}

public class CSVReader
{

	public readonly string Del;
	public readonly string[] Headers;
	public readonly Type[] Types;

	public CSVReader(string del, string[] headers)
	{
		Del = del;
		Headers = new string[headers.Length];
		Array.Copy(headers, Headers, headers.Length);
	}

	public Dictionary<string, List<String>> Read(string filename)
	{
		Dictionary<string, List<String>> result = new Dictionary<string, List<String>>();
		for(int i = 0; i < Headers.Length; i++)
		{
			result.Add(Headers[i], new List<string>());
		}

		using (StreamReader reader = new StreamReader(File.Open(filename, FileMode.Open, FileAccess.Read, FileShare.ReadWrite)))
		{
			try
			{

				char[] DelAsCharArray = Del.ToCharArray();
				reader.ReadLine(); // Read past first line

				while(reader.EndOfStream == false)
				{
					string line = reader.ReadLine();
					string[] values = line.Split(DelAsCharArray);
					for(int i = 0; i < values.Length; i++)
					{
						result[Headers[i]].Add(values[i]);
					}
				}

				return result;
			}
			catch (Exception e)
			{
				throw e;
			}
			finally
			{
				reader.Close();
			}

		}
	}
}
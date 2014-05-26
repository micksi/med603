using UnityEngine;
using System.Collections;
using System;
using System.IO;
using System.Text;

public class SimpleLogger 
{
	private string path;
	private StringBuilder contents = null;

	public SimpleLogger(string path)
	{
		this.path = path;	
		WriteLineWithTimestamp("Constructed logger");
        Debug.Log("Created SimpleLogger with path " + path);
	}

	public void WriteLine(string text)
	{
		if(contents == null)
		{
			contents = new StringBuilder(500);
		}
		else if(contents.MaxCapacity < contents.Length + text.Length)
		{
			Flush();
			WriteLine(text);
			return;
		}

		contents.AppendLine(text);
	}

	public void WriteLineWithTimestamp(string text)
	{
		WriteLine(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss:fffffff") + "," + text);
	}

	public void Flush()
	{
		if(contents == null)
		{
			Debug.Log("Can't flush; is empty.");
			return;
		}

		System.IO.File.AppendAllText(path,contents.ToString());
	}

}

using UnityEngine;
using System;
using System.IO;
using System.Collections;

public class ScreenShot : MonoBehaviour
{
	void Start()
	{
		//StartCoroutine(SavePng());
    }

	void Update()
	{
		if(Input.GetKeyDown("s"))
		{
			StartCoroutine(SavePng());
		}
	}

    IEnumerator SavePng()
    {
        yield return new WaitForEndOfFrame();
        int width = Screen.width;
        int height = Screen.height;
        Texture2D tex = new Texture2D(width, height, TextureFormat.RGB24, false);
        tex.ReadPixels(new Rect(0, 0, width, height), 0, 0);
        tex.Apply();

        byte[] bytes = tex.EncodeToPNG();
		string path = Application.dataPath + "/ScreenShot.png";
		FileStream file = File.Open(path, FileMode.Create);

		BinaryWriter writer = new BinaryWriter(file);
		Debug.Log ("Writing " + bytes.Length + " bytes to file " + path);
		writer.Write(bytes);
		writer.Close();
        Destroy(tex);
		Debug.Log ("Done writing");
		yield return false;
        
    }
}
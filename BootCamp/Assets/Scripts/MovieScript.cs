using UnityEngine;
using System.Collections;

public class MovieScript : MonoBehaviour {

	int buttonSize 		= 200;
	int buttonHeight	= 100;

	string projectPath;
	
	// Use this for initialization
	void Start () {
		projectPath = Application.dataPath + "/Movie/";
		print (projectPath);

	}

	// Update is called once per frame
	void Update () {

	}

	void OnGUI()
	{
		if(GUI.Button(new Rect((Screen.width/2)- buttonSize/2, (Screen.height/3)- buttonSize/2, buttonSize, buttonHeight), "Watch Anti-aliasing Movie"))
		{
			Application.OpenURL(projectPath + "Aa-Movie_the_final.wmv");
		}

		if(GUI.Button(new Rect((Screen.width/2)- buttonSize/2, (Screen.height/3)*2- buttonSize/2, buttonSize, buttonHeight), "Proceed with the test"))
		{
			print ("Experiment Scene");
			Application.LoadLevel("Experiment1");
		}
	}
}

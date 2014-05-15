﻿using UnityEngine;
using System.Collections;

public class ObjectiveController : MonoBehaviour {
	
	public GameObject[] checkpoint = null;
	public static int getNextObjective = 0;
	
	//[HideInInspector]
	public GameObject currentObjective;
	
	private Rect dialogRect;

	bool isBig 			= true;
	Vector2 boxSize		= new Vector2(200,200);
	Vector2 boxPos		= new Vector2(0,0); 
	
	Vector2 smallPos	= new Vector2(Screen.width-170,Screen.height/2-20);
	Vector2 smallBox 	= new Vector2(200, 150);
	Vector2 bigPos		= new Vector2(100,100);
	Vector2 bigBox;

	float bigLetters;
	float smallLetters;

	int labelOffset		= 30;
	float counter 		= 0;

	public GUIStyle fontStyle;
	public GUIStyle fontStyle2;

	string key = "h";

	// Use this for initialization
	void Start () {
		bigBox = new Vector2((Screen.width-bigPos.x*2)/2, Screen.height-bigPos.y*2);
		smallLetters = Screen.width/100.0f;
		bigLetters = Screen.width/40.0f;
		GoBig();
		if(checkpoint != null)
		{
			currentObjective = checkpoint[getNextObjective];
			currentObjective.GetComponent<ObjectiveDialog>().current = true;
		}
	}


	void Update()
	{
		if(isBig == false)
		{ 
			currentObjective.GetComponent<ObjectiveDialog>().deactivateCamera();
			if(counter < 1)
			{
				lerpylerp();
			}
		}
	}

	void lerpylerp()
	{
		counter += Time.deltaTime*2;
		boxPos = Vector2.Lerp(bigPos, smallPos, counter);
		boxSize = Vector2.Lerp(bigBox, smallBox, counter);
		fontStyle.fontSize  = (int)Mathf.Lerp(bigLetters,smallLetters,counter);
	}

	void GoBig()
	{
		fontStyle.fontSize = (int)bigLetters;
		boxSize = bigBox;
		boxPos 	= bigPos;
	}
	
	void OnGUI()
	{
		dialogRect 	= new Rect(boxPos.x + labelOffset, boxPos.y + labelOffset,boxSize.x - labelOffset*2,boxSize.y - labelOffset*2);
		GUI.Box(new Rect(boxPos.x,boxPos.y,boxSize.x,boxSize.y)," ");
		if(isBig)
		{
			currentObjective.GetComponent<ObjectiveDialog>().activateCamera();
			GoBig();
			GUI.Label(dialogRect, "Press \"" + key + "\" on the keyboad to minimize", fontStyle2);
			if(Input.GetKeyDown(key))
			{
				currentObjective.GetComponent<ObjectiveDialog>().deactivateCamera();
				counter = 0;
				isBig = false;
			}
		}
		
		if(currentObjective.GetComponent<ObjectiveDialog>().current)
		{
			GUI.Label(dialogRect, "OBJECTIVE: \n\n" + currentObjective.GetComponent<ObjectiveDialog>().dialog, fontStyle);
		}
		else
		{
			GoBig();
			GUI.Label(dialogRect,"No more objectives.\n Thank you for participating!", fontStyle);
		}
		fontStyle2.fontSize = fontStyle.fontSize;
	}

	void OnTriggerEnter(Collider other)
	{
		if(other.gameObject == currentObjective)
		{
			currentObjective.GetComponent<ObjectiveDialog>().current = false;
			
			getNextObjective++;
			if(checkpoint.Length > getNextObjective)
			{
				currentObjective = checkpoint[getNextObjective];
				currentObjective.GetComponent<ObjectiveDialog>().current = true;
				isBig = true;
			}
			else
			{
				//print ("no more objectives");
			}
		}
	}
}

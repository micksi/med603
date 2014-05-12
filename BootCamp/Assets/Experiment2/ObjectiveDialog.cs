using UnityEngine;
using System.Collections;

public class ObjectiveDialog : MonoBehaviour {

	public string dialog;

	[HideInInspector]
	public bool current = false;
	private bool justFound = true;
	

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if(current && justFound)
		{
			Debug.Log("play sound");
			audio.Play();
			justFound = false;
		}
	}
	
}

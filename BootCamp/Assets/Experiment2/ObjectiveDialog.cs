using UnityEngine;
using System.Collections;

public class ObjectiveDialog : MonoBehaviour {

	public string dialog;
	public GameObject CameraShot;

	[HideInInspector]
	public bool current = false;
	private bool justFound = true;
	

	// Use this for initialization
	void Start () {
		//activateCamera();
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

	public void activateCamera()
	{
		print ("Activating camera");
		CameraShot.SetActive(true);
	}

	public void deactivateCamera()
	{
		CameraShot.SetActive(false);
	}
	
}

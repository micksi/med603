using UnityEngine;
using System.Collections;

public class ObjectiveDialog : MonoBehaviour {

	public string dialog;

	[HideInInspector]
	public bool currentObjective = false;

	private Rect dialogRect;
	
	// Use this for initialization
	void Start () {
		dialogRect = new Rect(Screen.width-150, Screen.height/2,140,50);
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	void OnGUI()
	{
		if(currentObjective)
		{
			GUI.Label(dialogRect,dialog);
		}
	}
}

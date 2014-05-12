using UnityEngine;
using System.Collections;

public class ObjectiveController : MonoBehaviour {

	public GameObject[] checkpoint = null;
	public static int getNextObjective = 0;

	[HideInInspector]
	public GameObject currentObjective;

	private Rect dialogRect;
	
	// Use this for initialization
	void Start () {
		if(checkpoint != null)
		{
			currentObjective = checkpoint[getNextObjective];
			currentObjective.GetComponent<ObjectiveDialog>().current = true;
		}
	
		dialogRect = new Rect(Screen.width-160, Screen.height/2,140,50);
	}
	
	// Update is called once per frame
	void Update () 
	{

	}

	void OnGUI()
	{
		GUI.Box(new Rect(Screen.width-170, Screen.height/2-20,160,70),"Objective:");

		if(currentObjective.GetComponent<ObjectiveDialog>().current)
		{
			GUI.Label(dialogRect,currentObjective.GetComponent<ObjectiveDialog>().dialog);
		}
		else
		{
			GUI.Label(dialogRect,"No more objectives");
		}
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
			}
			else
			{
				print ("no more objectives");
			}
		}
	}
}

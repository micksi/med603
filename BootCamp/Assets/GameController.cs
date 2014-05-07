using UnityEngine;
using System.Collections;

public class GameController : MonoBehaviour {

	public GameObject[] checkpoint = null;
	private GameObject objective;
	private int getNextObjective = 0;
	// Use this for initialization
	void Start () {
		if(checkpoint != null)
		{
			objective = checkpoint[getNextObjective];
			objective.GetComponent<ObjectiveDialog>().currentObjective = true;
		}

	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnTriggerEnter(Collider other)
	{
		if(other.gameObject == objective)
		{
			objective.GetComponent<ObjectiveDialog>().currentObjective = false;

			getNextObjective++;
			if(checkpoint.Length > getNextObjective)
			{
				objective = checkpoint[getNextObjective];
				objective.GetComponent<ObjectiveDialog>().currentObjective = true;
			}
			else
			{
				print ("no more objectives");
			}
		}
	}
}

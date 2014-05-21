using UnityEngine;
using System.Collections;

public class SELFDESTRUCT : MonoBehaviour {

	public GameObject FPS;
	public bool soldierIsInUse;

	public static bool isSoldier;

	// Use this for initialization
	void Start () {
		if(soldierIsInUse == true)
		{
			FPS.SetActive(false);
			isSoldier = true;
		}
		else
		{
			isSoldier = false;
			this.gameObject.SetActive(false);
		}
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}

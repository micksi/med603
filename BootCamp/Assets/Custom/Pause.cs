using UnityEngine;
using System.Collections;

public class Pause : MonoBehaviour {
	private bool isPaused = false;
	public KeyCode pauseKey = KeyCode.P;

	// Use this for initialization
	void Start () 
	{
	
	}
	
	// Update is called once per frame
	void Update () 
	{
		if(Input.GetKeyDown(pauseKey))
		{
			if(isPaused)
			{
				isPaused = false;
				Time.timeScale = 1.0f;
			}
			else
			{
				isPaused = true;
				Time.timeScale = 0.0f;
			}
			//print (isPaused);
		}
	}
}

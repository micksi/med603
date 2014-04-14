using UnityEngine;
using System.Collections;
using ThresholdFinding;

public class SimpleThresholdDisplay : MonoBehaviour {

	
	public ThresholdFinderComponent finder;

	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		this.transform.position = new Vector3(transform.position.x, transform.position.y, (float)finder.Stimulus * -100);
	}
}

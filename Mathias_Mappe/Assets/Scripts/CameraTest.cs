﻿using UnityEngine;
using System.Collections;

public class CameraTest : MonoBehaviour {

	public GameObject Box;
	Vector3 temp;


	// Use this for initialization
	void Start () {

	}
	
	//public Transform target;

	void Update() {
		temp = Input.mousePosition;
		//print (temp);
		temp.z = Box.transform.position.z-camera.transform.position.z;
		Box.transform.position = camera.ScreenToWorldPoint(temp);
	} 
}

﻿using UnityEngine;
using System.Collections;

public class CameraTest : MonoBehaviour {

	public GameObject Box;
	Vector3 temp;

	FingerGun wiiPos;

	// Use this for initialization
	void Start () {
		//Screen.showCursor = false;
	}

	void Update() {
		wiiPos = GameObject.Find("gun").GetComponent<FingerGun>();
		temp = wiiPos.wiiPos;
		temp.z = 100.0f;
		Box.transform.position = camera.ScreenToWorldPoint(temp);
	} 
}

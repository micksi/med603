using UnityEngine;
using System.Collections;
using System;

public class ObjectiveController : MonoBehaviour
{

    public bool isSoldier;
    public GameObject soldier_cam;
    public GameObject[] checkpoints = null;
    public static int getNextObjective = 0;
    
    //[HideInInspector]
    public GameObject currentObjective;
    public SimpleLogger logger = null;

    public event EventHandler<ExitCheckpointArgs> ExitCheckpointEvent;

    private Rect dialogRect;
    bool isBig = true;
    Vector2 boxSize = new Vector2(200, 200);
    Vector2 boxPos = new Vector2(0, 0);
    Vector2 smallPos = new Vector2(Screen.width - 170, Screen.height / 2 - 20);
    Vector2 smallBox = new Vector2(200, 200);
    Vector2 bigPos = new Vector2(100, 100);
    Vector2 bigBox;
    float bigLetters;
    float smallLetters;
    int labelOffset = 30;
    float counter = 0;
    public GUIStyle fontStyle;
    public GUIStyle fontStyle2;
    string key = "e";

    void Awake()
    {
        if (soldier_cam == null)
            soldier_cam = Camera.main.gameObject;
    }

    // Use this for initialization
    void Start()
    {
        bigBox = new Vector2((Screen.width - bigPos.x * 2) / 2, Screen.height - bigPos.y * 2);
        smallLetters = Screen.width / 100.0f;
        bigLetters = Screen.width / 40.0f;
       
        GoBig();
        if (checkpoints != null)
        {
            currentObjective = checkpoints [getNextObjective];
            currentObjective.GetComponent<ObjectiveDialog>().current = true;
        }
    }

    public void Freeze()
    {
        GetComponent<CharacterMotor>().canControl = false;
        GetComponent<FPSInputController>().enabled = false;
        GetComponent<MouseLook>().enabled = false;
        soldier_cam.GetComponent<MouseLook>().enabled = false;
        Screen.showCursor = true;
        Screen.lockCursor = false;
    }
    
    public void Unfreeze()
    {
        GetComponent<CharacterMotor>().canControl = true;
        GetComponent<FPSInputController>().enabled = true;  
        GetComponent<MouseLook>().enabled = true;
        soldier_cam.GetComponent<MouseLook>().enabled = true;
        Screen.showCursor = false;
        Screen.lockCursor = true;

        logger.WriteLineWithTimestamp("Unfreeze");
    }

    public GameObject mapCam;

    void Update()
    {
        if (Input.GetKeyDown("tab"))
        {
            Freeze();
            mapCam.transform.position = transform.position + transform.up * 60;
            mapCam.SetActive(true);
            logger.WriteLineWithTimestamp("Open map");
        } 
        else if (Input.GetKeyUp("tab"))
        {
            Unfreeze();
            mapCam.SetActive(false);
            logger.WriteLineWithTimestamp("Close map");
        }

        if (isBig == false)
        { 
            currentObjective.GetComponent<ObjectiveDialog>().deactivateCamera();
            if (counter < 1)
            {
                lerpylerp();
            }
        }
    }

    void lerpylerp()
    {
        counter += Time.deltaTime * 2;
        boxPos = Vector2.Lerp(bigPos, smallPos, counter);
        boxSize = Vector2.Lerp(bigBox, smallBox, counter);
        fontStyle.fontSize = (int)Mathf.Lerp(bigLetters, smallLetters, counter);
    }

    void GoBig()
    {
        fontStyle.fontSize = (int)bigLetters;
        boxSize = bigBox;
        boxPos = bigPos;
    }

    void OnGUI()
    {
        dialogRect = new Rect(boxPos.x + labelOffset, boxPos.y + labelOffset, boxSize.x - labelOffset * 2, boxSize.y - labelOffset * 2);
        GUI.Box(new Rect(boxPos.x, boxPos.y, boxSize.x, boxSize.y), " ");
        if (isBig)
        {
            //this.transform.parent = null;
            Freeze();
            currentObjective.GetComponent<ObjectiveDialog>().activateCamera();
            GoBig();
            GUI.Label(dialogRect, "\n\n\nRemember to set the pixelation level so that you can't see it before you reach the next checkpoint." 
                      + "\nYou are at the red square. \n\nPress the \"" + key + "\" keyboard key to minimize", fontStyle2);
            if (Input.GetKeyDown(key))
            {
                Unfreeze();
                currentObjective.GetComponent<ObjectiveDialog>().deactivateCamera();
                counter = 0;
                isBig = false;
                logger.WriteLineWithTimestamp("Going small");

                ExitCheckpointEvent(this, new ExitCheckpointArgs(getNextObjective));
            }
        }
        
        if (currentObjective.GetComponent<ObjectiveDialog>().current)
        {
            GUI.Label(dialogRect, "OBJECTIVE: \n\n" + currentObjective.GetComponent<ObjectiveDialog>().dialog, fontStyle);
        } 
        else
        {
            GoBig();
            //GUI.Label(dialogRect,"No more objectives.\n Thank you for participating!", fontStyle);
            if (isSoldier)
            {
                soldier_cam.GetComponent<ExperimentConductor>().state = ExperimentConductor.State.EndTrials;
            } 
            else
            {
                soldier_cam.GetComponent<ExperimentConductor>().state = ExperimentConductor.State.EndTrials;
            }
        }
        fontStyle2.fontSize = fontStyle.fontSize;
    }

    void OnControllerColliderHit(ControllerColliderHit hit)
    {
        if (hit.collider.isTrigger)
            OnTriggerEnter(hit.collider);
    }

    void OnTriggerEnter(Collider other)
    {
        print("OnTriggerEnter");
        if (other.gameObject == currentObjective)
        {
            currentObjective.GetComponent<ObjectiveDialog>().current = false;
            
            logger.WriteLineWithTimestamp("Hit objective " + getNextObjective);

            getNextObjective++;
            if (checkpoints.Length > getNextObjective)
            {
                currentObjective = checkpoints [getNextObjective];
                currentObjective.GetComponent<ObjectiveDialog>().current = true;
                isBig = true;
            } 
            else
            {
                Screen.showCursor = true;
                //print ("no more objectives");
                logger.WriteLineWithTimestamp("No more objectives");
            }
        }
    }

    void OnApplicationQuit()
    {
        logger.Flush();
    }

    public class ExitCheckpointArgs : EventArgs
    {
        public int CheckpointID;

        public ExitCheckpointArgs(int CheckpointID)
        {
            this.CheckpointID = CheckpointID;
        }
    }
}

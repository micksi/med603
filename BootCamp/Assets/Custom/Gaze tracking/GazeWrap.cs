using UnityEngine;
using System.Collections;
using TETCSharpClient;
using TETCSharpClient.Data;
using Assets.Scripts;

public class GazeWrap : MonoBehaviour, IGazeListener
{
    private GazeDataValidator gazeUtils;
    private bool debugSupressWarning = false;

	void Start () 
    {
        gazeUtils = new GazeDataValidator(15);

        //activate C# TET client
        GazeManager.Instance.Activate
            (
                GazeManager.ApiVersion.VERSION_1_0,
                GazeManager.ClientMode.Push
            );

        //register for gaze updates
        GazeManager.Instance.AddGazeListener(this);
	}

    public void OnGazeUpdate(GazeData gazeData) 
    {
        //Add frame to GazeData cache handler
        gazeUtils.Update(gazeData);
    }

    public void OnCalibrationStateChanged(bool isCalibrated)
    {
    }

    public void OnScreenIndexChanged(int screenIndex) 
    {
    }

    void Update()
    {
        //handle keypress
        if (Input.GetKey(KeyCode.Escape))
        {
            Application.Quit();
        }

        if (Input.GetKeyDown(KeyCode.Alpha7))
        {
            debugSupressWarning = !debugSupressWarning;
        }

    }

    void OnGUI()
    {
        if(debugSupressWarning) return;
        
        if (!GazeManager.Instance.IsConnected)
        {
            GUI.TextArea(GenerateCrazyRect(), "EyeTribe Server not running!");
        }
        else if (!GazeManager.Instance.IsCalibrated)
        {
            GUI.TextArea(GenerateCrazyRect(), "EyeTribe Server not calibrated!");
        }
    }

    private Rect GenerateCrazyRect()
    {
        Vector2 screensize = FocusProvider.GetScreenResolution();
        int deviation = (int)(screensize.x / 12);
        int x = (int)(screensize.x / 3) + (int)(Random.value * deviation - deviation / 2);
        int y = (int)(screensize.y / 3) + (int)(Random.value * deviation - deviation / 2);
        int w = (int)(screensize.x / 3);
        int h = (int)(screensize.y / 3);

        return new Rect(x, y, w, h);
    }

    void OnApplicationQuit()
    {
        GazeManager.Instance.RemoveGazeListener(this);
        GazeManager.Instance.Deactivate();
    }

    public Vector3 GetGazeScreenPosition() 
    {
        Point2D gp = gazeUtils.GetLastValidSmoothedGazeCoordinates();

        if (null != gp)
        {
            Point2D sp = UnityGazeUtils.getGazeCoordsToUnityWindowCoords(gp);
            return new Vector3((float)sp.X, (float)sp.Y, 0f);
        }
        else
            return Vector3.zero;

    }
}

using UnityEngine;
using System.Collections;

public interface IApplyCSF {
	void SetCSF(RenderTexture csf);
	void ApplyEffect(RenderTexture source, RenderTexture dest);
}

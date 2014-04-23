using UnityEngine;
using System;
using System.IO;
using System.Collections.Generic;

namespace TestFramework
{
	public abstract class AbstractExperiment
	{
		public abstract Participant NewParticipant();
		public abstract void Begin();
	}
}
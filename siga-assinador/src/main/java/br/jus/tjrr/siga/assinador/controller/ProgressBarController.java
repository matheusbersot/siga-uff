package br.jus.tjrr.siga.assinador.controller;

import netscape.javascript.JSObject;

public class ProgressBarController {

	private static JSObject jsObject;

	public static void setJsObject(JSObject jsObject) {
		ProgressBarController.jsObject = jsObject;
	}
	
	public static void setNumSteps(int num)
	{
		jsObject.call("setNumStepsProgressBar", new Object[] {num});
	}
	
	public static void runProgressBar()
	{
		jsObject.eval("gProgressBar.run()");
	}
	
	public static void finalizeProgressBar()
	{
		jsObject.eval("gProgressBar.finalize()");
	}
	
	public static void nextStep()
	{
		jsObject.eval("gProgressBar.nextStep()");
	}
	
	public static void setMessage(String msg)
	{
		jsObject.call("setMessageProgressBar", new Object[] {msg});
	}
	
	public static void restartIndex()
	{
		jsObject.eval("gProgressBar.restartIndex()");
	}
}

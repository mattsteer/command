using System;
using System.IO;
using System.Diagnostics;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Collections.ObjectModel;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.Text;

public class Program
{
	public static void Main()
	{

		Runspace runspace = RunspaceFactory.CreateRunspace();
		runspace.Open();
		
		while(true)
		{			
			Console.Write(">");
			Pipeline pipeline = runspace.CreatePipeline();
			string cmd = Console.ReadLine();
			pipeline.Commands.AddScript(cmd);
			//Prep PS for string output and invoke
			pipeline.Commands.Add("Out-String");
			try
			{
				Collection<PSObject> results = pipeline.Invoke();
				//Convert records to strings
				StringBuilder stringBuilder = new StringBuilder();
				foreach (PSObject obj in results)
				{
					stringBuilder.Append(obj);
				}

				Console.WriteLine(stringBuilder.ToString().Trim());
			}
			catch(Exception e)
			{
				Console.WriteLine(e.ToString());
			}
		}
	}	
}
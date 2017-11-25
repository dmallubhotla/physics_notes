(* ::Package:: *)

BeginPackage["DrudeTheoryScript`"]

CurrentDir = DirectoryName[FileNameJoin[{Directory[], $ScriptCommandLine[[1]]}]]
ImageDir = FileNameJoin[{CurrentDir, "images"}]
outFile = OpenWrite[FileNameJoin[{CurrentDir, "DrudeTheoryScriptOutput.txt"}]]

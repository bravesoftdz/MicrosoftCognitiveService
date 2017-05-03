unit uFunctions.FaceApiHelper;

interface

uses
  { TDetectOptions }
  uFaceApi.FaceDetectOptions,
  { TBytesStream }
  System.Classes,
  { TAccess }
  uFaceApi.ServersAccess.Types;

type
  FaceApiHelper = class
    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi|IFaceApi.DetectURL">interface DetectURL</see>
    /// </summary>
    class function DetectURL(AAccess: TAccessServer; const AURL: String; const ADetectOptions: TDetectOptions): String;
    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi|IFaceApi.DetectFile">interface DetectFile</see>
    /// </summary>
    class function DetectFile(AAccess: TAccessServer; const AFileName: String; const ADetectOptions: TDetectOptions): String;
    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi|IFaceApi.DetectStream">interface DetectStream</see>
    /// </summary>
    class function DetectStream(AAccess: TAccessServer; AStream: TBytesStream; const ADetectOptions: TDetectOptions): String;

    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi.PersonGroup|IFaceApiPersonGroup.ListPersonGroups">interface ListPersonGroups</see>
    /// </summary>
    class function ListPersonGroups(AAccess: TAccessServer; const AStart: String = ''; const ATop: Integer = 1000): String;

    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi|IFaceApi.ListPersonsInPersonGroup">interface ListPersonsInPersonGroup</see>
    /// </summary>
    class function ListPersonsInPersonGroup(AAccess: TAccessServer; const AGroupID: String): String;

    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi|IFaceApi.CreatePerson">interface CreatePerson</see>
    /// </summary>
    class function CreateNewPerson(AAccess: TAccessServer; AGroupID: String; APersonName: String; APersonUserData: String): String;

    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi.PersonGroup|IFaceApiPersonGroup.GetPersonGroupTrainingStatus">interface GetPersonGroupTrainingStatus</see>
    /// </summary>
    class function GetPersonGroupTrainingStatus(AAccess: TAccessServer; const AGroupID: String): String;
    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi.PersonGroup|IFaceApiPersonGroup.TrainPersonGroup">interface TrainPersonGroup</see>
    /// </summary>
    class function TrainPersonGroup(AAccess: TAccessServer; const AGroupID: String): String;

    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi.PersonGroup|IFaceApiPersonGroup.CreatePersonGroup">interface CreatePersonGroup</see>
    /// </summary>
    class function CreatePersonGroup(AAccess: TAccessServer; const AGroupID, AGroupName, AGroupUserData: String): String;

    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi.PersonGroup|IFaceApiPersonGroup.DeletePersonGroup">interface DeletePersonGroup</see>
    /// </summary>
    class function DeletePersonGroup(AAccess: TAccessServer; const AGroupID: String): String;

    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi|IFaceApi.Verify">interface Verify (overload)</see>
    /// </summary>
    class function Verify(AAccess: TAccessServer; const AFaceTempID1, AFaceTempID2: String): String; overload;
    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi|IFaceApi.Verify">interface Verify (overload)</see>
    /// </summary>
    class function Verify(AAccess: TAccessServer; const AFaceTempID, APersonID, AGroupID: String): String; overload;

    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi|IFaceApi.Identify">interface Identify</see>
    /// </summary>
    class function Identify(AAccess: TAccessServer; AFaceIDS: TStringList; const AGroupID: String; const AMaxNumOfCandidatesReturned: Integer = 1; const AConfidenceThreshold: Double = 0.5): String;

    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi.PersonGroup|IFaceApi.Identify">interface UpdatePersonGroup</see>
    /// </summary>
    class function UpdatePersonGroup(AAccess: TAccessServer; const AGroupID: String; const AGroupName: String; const AGroupUserData: String): String;

    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi.PersonGroup|IFaceApiPersonGroup.Identify">interface UpdatePersonGroup</see>
    /// </summary>
    class function GetPersonGroup(AAccess: TAccessServer; const AGroupID: String): String;

    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi|IFaceApi.FindSimilar">interface FindSimilar</see>
    /// </summary>
    class function FindSimilar(AAccess: TAccessServer; const AFaceID: String; const AListID: String; const AMaxNumOfCandidatesReturned: Integer = 20; AFindMode: String = 'matchPerson'): String; overload;

    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi|IFaceApi.FindSimilar">interface FindSimilar</see>
    /// </summary>
    class function FindSimilar(AAccess: TAccessServer; const AFaceID: String; AFaceIDS: TStringList; const AMaxNumOfCandidatesReturned: Integer = 20; AFindMode: String = 'matchPerson'): String; overload;

    /// <summary>
    ///   Implements top layout for <see cref="uIFaceApi|IFaceApi.Group">interface Group</see>
    /// </summary>
    class function Group(AAccess: TAccessServer; AFaceIDS: TStringList): String;
  end;

implementation

uses
  { IFaceApi }
  uIFaceApi,
  { TFaceApiCore }
  uFaceApi.Core,
  { IFaceApiFace }
  uIFaceApi.Face,
  { TFaceApiCoreFace }
  uFaceApi.Core.Face,
  { IFaceApiPersonGroup }
  uIFaceApi.PersonGroup,
  { TFaceApiCorePersonGroup }
  uFaceApi.Core.PersonGroup;

class function FaceApiHelper.CreateNewPerson(AAccess: TAccessServer; AGroupID: String; APersonName: String; APersonUserData: String): String;
var
  LIFaceApi: IFaceApi;
begin
  LIFaceApi := TFaceApiCore.Create;

  LIFaceApi.SetAccessKey(AAccess);

  Result := LIFaceApi.CreatePerson(AGroupID, APersonName, APersonUserData);
end;

class function FaceApiHelper.CreatePersonGroup(AAccess: TAccessServer; const AGroupID, AGroupName, AGroupUserData: String): String;
var
  LIFaceApiPersonGroup: IFaceApiPersonGroup;
begin
  LIFaceApiPersonGroup := TFaceApiCorePersonGroup.Create;

  LIFaceApiPersonGroup.SetAccessKey(AAccess);

  Result := LIFaceApiPersonGroup.CreatePersonGroup(AGroupID, AGroupName, AGroupUserData);
end;

class function FaceApiHelper.DeletePersonGroup(AAccess: TAccessServer; const AGroupID: String): String;
var
  LIFaceApiPersonGroup: IFaceApiPersonGroup;
begin
  LIFaceApiPersonGroup := TFaceApiCorePersonGroup.Create;

  LIFaceApiPersonGroup.SetAccessKey(AAccess);

  Result := LIFaceApiPersonGroup.DeletePersonGroup(AGroupID);
end;

class function FaceApiHelper.DetectFile(AAccess: TAccessServer; const AFileName: String; const ADetectOptions: TDetectOptions): String;
var
  LIFaceApiFace: IFaceApiFace;
begin
  LIFaceApiFace := TFaceApiCoreFace.Create;

  LIFaceApiFace.SetAccessKey(AAccess);

  Result := LIFaceApiFace.DetectFile(AFileName, ADetectOptions);
end;

class function FaceApiHelper.DetectStream(AAccess: TAccessServer; AStream: TBytesStream; const ADetectOptions: TDetectOptions): String;
var
  LIFaceApiFace: IFaceApiFace;
begin
  LIFaceApiFace := TFaceApiCoreFace.Create;

  LIFaceApiFace.SetAccessKey(AAccess);

  Result := LIFaceApiFace.DetectStream(AStream, ADetectOptions);
end;

class function FaceApiHelper.DetectURL(AAccess: TAccessServer; const AURL: String; const ADetectOptions: TDetectOptions): String;
var
  LIFaceApiFace: IFaceApiFace;
begin
  LIFaceApiFace := TFaceApiCoreFace.Create;

  LIFaceApiFace.SetAccessKey(AAccess);

  Result := LIFaceApiFace.DetectURL(AURL, ADetectOptions);
end;

class function FaceApiHelper.GetPersonGroupTrainingStatus(AAccess: TAccessServer; const AGroupID: String): String;
var
  LIFaceApiPersonGroup: IFaceApiPersonGroup;
begin
  LIFaceApiPersonGroup := TFaceApiCorePersonGroup.Create;

  LIFaceApiPersonGroup.SetAccessKey(AAccess);

  Result := LIFaceApiPersonGroup.GetPersonGroupTrainingStatus(AGroupID);
end;

class function FaceApiHelper.ListPersonGroups(AAccess: TAccessServer; const AStart: String = ''; const ATop: Integer = 1000): String;
var
  LIFaceApiPersonGroup: IFaceApiPersonGroup;
begin
  LIFaceApiPersonGroup := TFaceApiCorePersonGroup.Create;

  LIFaceApiPersonGroup.SetAccessKey(AAccess);

  Result := LIFaceApiPersonGroup.ListPersonGroups(AStart, ATop);
end;

class function FaceApiHelper.ListPersonsInPersonGroup(AAccess: TAccessServer; const AGroupID: String): String;
var
  LIFaceApi: IFaceApi;
begin
  LIFaceApi := TFaceApiCore.Create;

  LIFaceApi.SetAccessKey(AAccess);

  Result := LIFaceApi.ListPersonsInPersonGroup(AGroupID);
end;

class function FaceApiHelper.TrainPersonGroup(AAccess: TAccessServer; const AGroupID: String): String;
var
  LIFaceApiPersonGroup: IFaceApiPersonGroup;
begin
  LIFaceApiPersonGroup := TFaceApiCorePersonGroup.Create;

  LIFaceApiPersonGroup.SetAccessKey(AAccess);

  Result := LIFaceApiPersonGroup.TrainPersonGroup(AGroupID);
end;

class function FaceApiHelper.Verify(AAccess: TAccessServer; const AFaceTempID1, AFaceTempID2: String): String;
var
  LIFaceApiFace: IFaceApiFace;
begin
  LIFaceApiFace := TFaceApiCoreFace.Create;

  LIFaceApiFace.SetAccessKey(AAccess);

  Result := LIFaceApiFace.Verify(AFaceTempID1, AFaceTempID2);
end;

class function FaceApiHelper.Verify(AAccess: TAccessServer; const AFaceTempID, APersonID, AGroupID: String): String;
var
  LIFaceApiFace: IFaceApiFace;
begin
  LIFaceApiFace := TFaceApiCoreFace.Create;

  LIFaceApiFace.SetAccessKey(AAccess);

  Result := LIFaceApiFace.Verify(AFaceTempID, APersonID, AGroupID);
end;

class function FaceApiHelper.Identify(AAccess: TAccessServer; AFaceIDS: TStringList; const AGroupID: String; const AMaxNumOfCandidatesReturned: Integer; const AConfidenceThreshold: Double): String;
var
  LIFaceApiFace: IFaceApiFace;
begin
  LIFaceApiFace := TFaceApiCoreFace.Create;

  LIFaceApiFace.SetAccessKey(AAccess);

  Result := LIFaceApiFace.Identify(AFaceIDS, AGroupID, AMaxNumOfCandidatesReturned, AConfidenceThreshold);
end;

class function FaceApiHelper.UpdatePersonGroup(AAccess: TAccessServer; const AGroupID, AGroupName, AGroupUserData: String): String;
var
  LIFaceApiPersonGroup: IFaceApiPersonGroup;
begin
  LIFaceApiPersonGroup := TFaceApiCorePersonGroup.Create;

  LIFaceApiPersonGroup.SetAccessKey(AAccess);

  Result := LIFaceApiPersonGroup.UpdatePersonGroup(AGroupID, AGroupName, AGroupUserData);
end;

class function FaceApiHelper.GetPersonGroup(AAccess: TAccessServer; const AGroupID: String): String;
var
  LIFaceApiPersonGroup: IFaceApiPersonGroup;
begin
  LIFaceApiPersonGroup := TFaceApiCorePersonGroup.Create;

  LIFaceApiPersonGroup.SetAccessKey(AAccess);

  Result := LIFaceApiPersonGroup.GetPersonGroup(AGroupID);
end;

class function FaceApiHelper.Group(AAccess: TAccessServer; AFaceIDS: TStringList): String;
var
  LIFaceApiFace: IFaceApiFace;
begin
  LIFaceApiFace := TFaceApiCoreFace.Create;

  LIFaceApiFace.SetAccessKey(AAccess);

  Result := LIFaceApiFace.Group(AFaceIDS);
end;

class function FaceApiHelper.FindSimilar(AAccess: TAccessServer; const AFaceID, AListID: String; const AMaxNumOfCandidatesReturned: Integer; AFindMode: String): String;
var
  LIFaceApiFace: IFaceApiFace;
begin
  LIFaceApiFace := TFaceApiCoreFace.Create;

  LIFaceApiFace.SetAccessKey(AAccess);

  Result := LIFaceApiFace.FindSimilar(AFaceID, AListID, AMaxNumOfCandidatesReturned, AFindMode);
end;

class function FaceApiHelper.FindSimilar(AAccess: TAccessServer; const AFaceID: String; AFaceIDS: TStringList; const AMaxNumOfCandidatesReturned: Integer; AFindMode: String): String;
var
  LIFaceApiFace: IFaceApiFace;
begin
  LIFaceApiFace := TFaceApiCoreFace.Create;

  LIFaceApiFace.SetAccessKey(AAccess);

  Result := LIFaceApiFace.FindSimilar(AFaceID, AFaceIDS, AMaxNumOfCandidatesReturned, AFindMode);
end;

end.

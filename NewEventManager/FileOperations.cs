using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.IO;
using System.Diagnostics;

/// <summary>
/// Summary description for FileOperations
/// </summary>
public class FileOperations
{
    public FileOperations()
    {
        //
        // TODO: Add constructor logic here
        //
    }


    public bool DirExists(string dirPath)
    {
        DirectoryInfo dirInf = null;
        try
        {
            dirInf = new DirectoryInfo(dirPath);
            return dirInf.Exists;
        }
        catch (Exception ex)
        {
            ErrorLog.WriteLog(dirPath + "  " + Environment.NewLine + ex.Message + Environment.NewLine + ex.StackTrace, ErrorLog.LogType.ErrorLog, "Fileoperation.DirExists()");
            return false;
        }
        finally
        {
            dirInf = null;
        }
    }

    public bool FileExists(string filePath)
    {
        FileInfo fileInf = null;
        try
        {
            fileInf = new FileInfo(filePath);
            return fileInf.Exists;
        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {
            fileInf = null;
        }
    }

    public bool CreateDir(string dirPath)
    {
        DirectoryInfo dirInf = null;
        try
        {
            if (!DirExists(dirPath))
            {
                Directory.CreateDirectory(dirPath);
                return true;
            }
            else
            {
                return true;
            }
        }
        catch (Exception ex)
        {
            ErrorLog.WriteLog("Cannot create directory : " + dirPath + "  " + Environment.NewLine + ex.Message + Environment.NewLine + ex.StackTrace, ErrorLog.LogType.ErrorLog, "Fileoperation.CreateDir");
            return false;
        }
        finally
        {
            dirInf = null;
        }
    }

    public string ReadFile(string filePath)
    {
        StreamReader fileReader = null;
        string data = null;
        try
        {
            if (FileExists(filePath))
            {
                fileReader = File.OpenText(filePath);
                data = fileReader.ReadToEnd();
                return data;
            }
            else
            {
                return "";
            }
        }
        catch (Exception ex)
        {
            return "";
        }
        finally
        {
            fileReader.Close();
            data = null;
        }
    }

    public bool CreateFile(string filePath, string data)
    {
        StreamWriter fileWriter = null;
        try
        {
            fileWriter = File.CreateText(filePath);
            fileWriter.Write(data);
            fileWriter.Flush();
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {
            fileWriter.Close();
        }
    }

    public bool WriteToFile(string filePath, string data)
    {
        StreamWriter fileWriter = null;
        FileInfo fileInf = null;
        try
        {
            fileWriter = fileInf.AppendText();
            fileWriter.Write(data);
            fileWriter.Flush();
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {
            fileWriter.Close();
        }
    }

    public bool CopyFile(string srcFilePath, string destFilePath)
    {
        FileInfo fileInf = null;
        try
        {
            fileInf = new FileInfo(srcFilePath);
            if ((fileInf.CopyTo(destFilePath) != null))
                return true;
            else
                return false;
        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {
            fileInf = null;
        }
    }

    public bool MoveFile(string srcFilePath, string destFilePath)
    {
        FileInfo fileInf = null;
        try
        {
            fileInf = new FileInfo(srcFilePath);
            fileInf.MoveTo(destFilePath);
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {
            fileInf = null;
        }
    }

    public bool DeleteFile(string filePath)
    {
        FileInfo fileInf = null;
        try
        {
            fileInf = new FileInfo(filePath);
            fileInf.Delete();
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {
            fileInf = null;
        }
    }

    public bool DeleteFiles(string strSourceFolder, string strMask)
    {
        string[] strFiles = null;
        string tempString = null;
        FileInfo tempFileInfo = null;
        try
        {
            foreach (string tempString_loopVariable in Directory.GetFiles(strSourceFolder, strMask))
            {
                tempString = tempString_loopVariable;
                if (File.Exists(tempString))
                {
                    tempFileInfo = new FileInfo(tempString);
                    tempFileInfo.Delete();
                }
            }
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {
            strFiles = null;
            tempString = null;
            tempFileInfo = null;
        }

    }

    public FileInfo[] GetFilesInDir(string dirPath)
    {
        DirectoryInfo dirInf = null;
        try
        {
            dirInf = new DirectoryInfo(dirPath);
            return dirInf.GetFiles();
        }
        catch (Exception ex)
        {
            return null;
        }
        finally
        {
            dirInf = null;
        }

    }

    public DirectoryInfo[] GetDirsInDir(string dirPath)
    {
        DirectoryInfo dirInf = null;
        try
        {
            dirInf = new DirectoryInfo(dirPath);
            return dirInf.GetDirectories();
        }
        catch (Exception ex)
        {
            return null;
        }
        finally
        {
            dirInf = null;
        }
    }

    public FileInfo[] GetFilesInDir(string dirPath, string strSearchPattern, System.IO.SearchOption srcOption)
    {
        DirectoryInfo dirInf = null;
        ErrorLog objErrorLog = new ErrorLog();
        try
        {
            dirInf = new DirectoryInfo(dirPath);
            return dirInf.GetFiles(strSearchPattern, srcOption);
        }
        catch (Exception ex)
        {
            ErrorLog.WriteLog(ex.Message + "\r\n" + ex.StackTrace, ErrorLog.LogType.ErrorLog, "GetFilesInDir(string,string,searchoptions");
            return null;
        }
        finally
        {
            dirInf = null;
            objErrorLog = null;
        }

    }

    public Int16 GetFileCount(string dirPath)
    {
        DirectoryInfo dirInfo = null;
        FileInfo[] fileInfo = null;
        try
        {
            dirInfo = new DirectoryInfo(dirPath);
            if (dirInfo.Exists)
            {
                fileInfo = dirInfo.GetFiles();
            }
            else
            {
                return 0;
            }
            if ((fileInfo != null))
            {
                return short.Parse(fileInfo.Length.ToString());
            }
            else
            {
                return 0;
            }
        }
        catch (Exception ex)
        {
            return -1;
        }
        finally
        {
            dirInfo = null;
            fileInfo = null;
        }
    }

    public string GetFileExt(string fileName)
    {
        FileInfo renFile = null;
        try
        {
            //If strDestPath.Contains("(0)") Then
            //    strDestPath = strDestPath.Replace("(0)", "")
            //End If
            //If strDestPath.Contains("006-01-") Then
            //    strDestPath = strDestPath.Replace("006-01-", "6")
            //End If

            renFile = new FileInfo(fileName);
            if (renFile.Exists)
            {
                return renFile.Extension;
            }
            return true.ToString();
        }
        catch (Exception ex)
        {
            return false.ToString();
        }
        finally
        {
            renFile = null;
        }
    }

    public bool HideFile(string filePath)
    {
        FileInfo fInfo = null;
        try
        {
            fInfo = new FileInfo(filePath);
            if (fInfo.Exists)
            {
                fInfo.Attributes = FileAttributes.Hidden;
            }
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {
            fInfo = null;
        }
    }

    public bool RenameFile(string strSourcePath, string strDestPath)
    {
        FileInfo renFile = null;
        try
        {
            //If strDestPath.Contains("(0)") Then
            //    strDestPath = strDestPath.Replace("(0)", "")
            //End If
            //If strDestPath.Contains("006-01-") Then
            //    strDestPath = strDestPath.Replace("006-01-", "6")
            //End If

            renFile = new FileInfo(strSourcePath);
            if (renFile.Exists)
            {
                renFile.MoveTo(strDestPath);

            }
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {
            renFile = null;
        }
    }

    //Public Function IsHidden(ByVal filePath As String) As Boolean
    //    Dim fInfo As FileInfo
    //    Dim objErrorLog As New clsErrorLog
    //    Try
    //        fInfo = New FileInfo(filePath)
    //        If fInfo.Exists() Then
    //            If fInfo.Attributes = FileAttributes.Hidden Then
    //                Return True
    //            Else
    //                Return False
    //            End If
    //        End If
    //    Catch ex As Exception
    //        objErrorLog.WriteLog(ex.Message & vbNewLine & ex.StackTrace, "E", "HideFile")
    //        Return False
    //    Finally
    //        fInfo = Nothing
    //        objErrorLog = Nothing
    //    End Try
    //End Function

    public bool IsHidden(string filePath)
    {
        System.IO.FileInfo fInfo = null;
        ErrorLog objErrorLog = new ErrorLog();
        try
        {
            fInfo = new System.IO.FileInfo(filePath);
            if (fInfo.Exists)
            {
                if ((fInfo.Attributes & System.IO.FileAttributes.Hidden) != 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return true;
            }
        }
        catch (Exception ex)
        {
            ErrorLog.WriteLog(ex.Message + "\r\n" + ex.StackTrace, ErrorLog.LogType.ErrorLog, "HideFile");
            return false;
        }
        finally
        {
            fInfo = null;
            objErrorLog = null;
        }
    }
}
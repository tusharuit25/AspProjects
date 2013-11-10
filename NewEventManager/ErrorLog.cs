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
/// Summary description for ErrorLog
/// </summary>
public class ErrorLog
{
    public ErrorLog()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static void WriteLog(string strErrDesc, LogType LogType1, string ErrorSource)
    {
        string strLogFileName = null;
        string strFolderPath = null;
        StreamWriter strStream = null;
        string strNewErrMsg = "";

        strNewErrMsg = "****************************************************************************" + "\r\n";
        strNewErrMsg = strNewErrMsg + " Date : " + System.DateTime.Now.ToShortDateString() + "        " + "Time : " + System.DateTime.Now.ToShortTimeString() + "\r\n";
        if (!string.IsNullOrEmpty(ErrorSource))
        {
            strNewErrMsg = strNewErrMsg + "Log Source : " + ErrorSource + "\r\n";
        }
        strNewErrMsg = strNewErrMsg + strErrDesc + "\r\n";
        strNewErrMsg = strNewErrMsg + "****************************************************************************" + "\r\n";
        strFolderPath = System.AppDomain.CurrentDomain.BaseDirectory;
        // Application Error 
        if (LogType1 == ErrorLog.LogType.ErrorLog)
        {
            strFolderPath += "Error_Log\\";
            // System Info
        }
        else if (LogType1 == ErrorLog.LogType.ApplicationLog)
        {
            strFolderPath += "App_Log\\";
        }
        //Dim FSO As New Scripting.FileSystemObject
        if (!Directory.Exists(strFolderPath))
        {
            Directory.CreateDirectory(strFolderPath);
        }

        // *************************************************
        DateTime time = DateTime.Now;
        string tname = time.Year.ToString("0000") + time.Month.ToString("00") + time.Day.ToString("00");
        //strLogFileName = strFolderPath + string.Format(System.DateTime.Now.ToString(), "yyyyMMdd") + ".txt";
        strLogFileName = strFolderPath + tname + ".txt";
        try
        {
            if (File.Exists(strLogFileName) == true)
            {
                FileInfo ffLength = new FileInfo(strLogFileName);
                if (ffLength.Length >= 54000)
                {
                    File.Move(strLogFileName, strFolderPath + string.Format(System.DateTime.Now.ToString("yyyyMMddHHmm")) + ".txt");
                }
                strStream = File.AppendText(strLogFileName);
                strStream.NewLine.Trim();
                strStream.Write(strNewErrMsg);
                strStream.Flush();
            }
            else
            {
                strStream = File.AppendText(strLogFileName);
                strStream.NewLine.Trim();
                strStream.Write(strNewErrMsg);
                strStream.Flush();
            }
        }
        catch (Exception exc)
        {
            ///''Error Message
        }
        finally
        {
            if ((strStream != null))
            {
                strStream.Close();
            }
        }
    }

    public void WriteStatusLog(string strFileName, Int16 status, string logSource, string strMsg)
    {
        string strLogFileName = null;
        string strFolderPath = null;
        StreamWriter strStream = null;
        string strNewErrMsg = "";

        if (status != 1080)
        {
            strNewErrMsg = "****************************************************************************" + "\r\n";
            strNewErrMsg = strNewErrMsg + " " + System.DateTime.Now.ToString() + "\r\n";
            if (!string.IsNullOrEmpty(logSource))
            {
                strNewErrMsg = strNewErrMsg + "Log Source : " + logSource + "\r\n";
            }
            strNewErrMsg = strNewErrMsg + strFileName + "\r\n";
            strNewErrMsg = strNewErrMsg + strMsg + "\r\n";
            strNewErrMsg = strNewErrMsg + "****************************************************************************" + "\r\n";
        }
        else
        {
            //strNewErrMsg = "****************************************************************************" & vbCrLf
            strNewErrMsg = strNewErrMsg + " " + System.DateTime.Now.ToString();
            if (!string.IsNullOrEmpty(logSource))
            {
                strNewErrMsg = strNewErrMsg + logSource;
            }
            strNewErrMsg = strNewErrMsg + strFileName + " ";
            strNewErrMsg = strNewErrMsg + strMsg + " ";
            strNewErrMsg = strNewErrMsg + "****************************************************************************" + "\r\n";
        }
        //If logSource <> "" Then
        //    strNewErrMsg = strNewErrMsg & "Log Source : " & logSource & vbTab
        //End If

        strFolderPath = System.AppDomain.CurrentDomain.BaseDirectory;

        strFolderPath += "FileStatus_Log\\";

        if (!Directory.Exists(strFolderPath))
        {
            Directory.CreateDirectory(strFolderPath);
        }

        // *************************************************
        strLogFileName = strFolderPath + "Status_" + status + "_" + string.Format(System.DateTime.Now.ToString(), "yyyyMMdd") + ".txt";
        try
        {
            if (File.Exists(strLogFileName) == true)
            {
                if (strLogFileName.Length >= 54000)
                {
                    File.Move(strLogFileName, strFolderPath + string.Format(System.DateTime.Now.ToString(), "yyyyMMddHHMMss") + ".txt");
                }
                strStream = File.AppendText(strLogFileName);
                strStream.NewLine.Trim();
                strStream.Write(strNewErrMsg);
                strStream.Flush();
            }
            else
            {
                strStream = File.AppendText(strLogFileName);
                strStream.NewLine.Trim();
                strStream.Write(strNewErrMsg);
                strStream.Flush();
            }
        }
        catch (Exception exc)
        {
            ///''Error Message
        }
        finally
        {
            if ((strStream != null))
            {
                strStream.Close();
            }
        }
    }

    public static void WriteCustomWatcherLog(string strMsg, string strLogFileName)
    {
        string strFolderPath = null;
        StreamWriter strStream = null;
        FileOperations objFile = new FileOperations();

        strFolderPath = System.AppDomain.CurrentDomain.BaseDirectory;

        strFolderPath += "FileEvents\\";

        if (!objFile.DirExists(strFolderPath))
        {
            objFile.CreateDir(strFolderPath);
        }

        // *************************************************
        //strLogFileName = strFolderPath & "Transfer_" & Format(Date.Now, "yyyyMMdd") & ".txt"
        try
        {
            if (File.Exists(strFolderPath + strLogFileName) == true)
            {
                if ((strFolderPath + strLogFileName).Length >= 54000)
                {
                    File.Move(strFolderPath + strLogFileName, strFolderPath + "Transfer_" + string.Format(System.DateTime.Now.ToString(), "yyyyMMddHHMMss") + ".txt");
                }
                strStream = File.AppendText(strFolderPath + strLogFileName);
                strStream.NewLine.Trim();
                strStream.Write(strMsg);
                strStream.Flush();
            }
            else
            {
                strStream = File.AppendText(strFolderPath + strLogFileName);
                strStream.NewLine.Trim();
                strStream.Write(strMsg);
                strStream.Flush();
            }
        }
        catch (Exception exc)
        {
            ///''Error Message
        }
        finally
        {
            if ((strStream != null))
            {
                strStream.Close();
            }
            strLogFileName = null;
            strFolderPath = null;
            objFile = null;
        }
    }

    public enum LogType
    {
        ErrorLog = 1,
        ApplicationLog = 2
    }
}
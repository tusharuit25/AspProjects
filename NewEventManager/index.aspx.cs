using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Text;
using System.Drawing.Imaging;
using System.Web.UI.HtmlControls;
using System.Drawing;
using System.Collections;
using System.Web.Caching;
using System.Configuration;


namespace NewEventManager
{
    public partial class index : System.Web.UI.Page
    {


        static string myDirAttendee = ConfigurationManager.AppSettings["myDirAttendee"];
        static string myDirExihibitor = ConfigurationManager.AppSettings["myDirExihibitor"];
        static string myDirSpeaker = ConfigurationManager.AppSettings["myDirSpeaker"];
        static string myDirSponsor = ConfigurationManager.AppSettings["myDirSponsor"];
        static string myDirMap = ConfigurationManager.AppSettings["myDirMap"];
        static string myDirNews = ConfigurationManager.AppSettings["myDirNews"];
        static string myDirBanner = ConfigurationManager.AppSettings["myDirBanner"];
        static string myAppCacheFile = ConfigurationManager.AppSettings["pathOfAppCacheFile"];
        static string myExhiMap = ConfigurationManager.AppSettings["myExhiMapImages"];

        static Byte[] imageData = null;

        //static string myDirNews = "C:\\inetpub\\wwwroot\\istageEvents\\EventApp\\imagesNews\\";
        //static string mySplash = "C:\\inetpub\\wwwroot\\istageEvents\\EventApp\\images\\";
        //static string myAppIcon = "C:\\inetpub\\wwwroot\\istageEvents\\EventApp\\images\\";
        //static Byte[] imageData = null;

        protected void Page_Load(object sender, EventArgs e)
        {

            Page.Header.Title = "ETF";// GetPageTitle();
            //SaveSplashIphoneImage();
            //SaveAppIconIphoneImage();

            HtmlMeta metaDescription = new HtmlMeta();
            metaDescription.Name = "apple-mobile-web-app-title";
            metaDescription.Content = "ETF";//GetPageIconName();
            Page.Header.Controls.Add(metaDescription);

            cpanelHeader.InnerText = "ETF";// GetPageTitle();
            divMsg.Visible = false;
            //livepollcontainer.Visible = false;

            if (FileUpload1.HasFile) { }
        }

        private static string GetPageTitle()
        {
            String title = "";
            String Query = "Select AppName From event_New_tbl_AppIcon order by id";
            DataSet Ds = GetDataSet(Query);
            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                title = Convert.ToString(row["AppName"].ToString());
            }
            return title;
        }

        private static string GetPageIconName()
        {
            String title = "";
            String Query = "Select AppIconName From event_New_tbl_AppIcon order by id";
            DataSet Ds = GetDataSet(Query);
            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                title = Convert.ToString(row["AppIconName"].ToString());
            }
            return title;
        }

        [WebMethod]
        public static SubscribedEvent[] getSubscribedEvents(int attendeeID)
        {
            SubscribedEvent[] se = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                se = getSubcribedEventSet(attendeeID).ToArray();
                return se;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return se;

            }

        }

        private static List<SubscribedEvent> getSubcribedEventSet(int attendeeID)
        {
            List<SubscribedEvent> currentCategories = new List<SubscribedEvent>();
            String Query = "SELECT     dbo.event_New_tbl_AttendeeToEvent.event_code, dbo.event_New_tbl_Event.event_name " +
                      " FROM         dbo.event_New_tbl_Event INNER JOIN " +
                      " dbo.event_New_tbl_AttendeeToEvent ON dbo.event_New_tbl_Event.event_code = dbo.event_New_tbl_AttendeeToEvent.event_code " +
                      " WHERE     (dbo.event_New_tbl_AttendeeToEvent.attendee_id = " + attendeeID + ")";
            DataSet Ds = GetDataSet(Query);

            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                SubscribedEvent Dt = new SubscribedEvent();
                Dt.EventCode = row["event_code"].ToString();
                Dt.EventName = row["event_name"].ToString();
                currentCategories.Add(Dt);
            }
            return currentCategories;
        }



        [WebMethod]
        public static UserDetails[] CheckAutheticationOnline(String username, String password)
        {

            UserDetails[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetUser(username, password).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }

        }
        [WebMethod]

        public static String FavoriteAttendeeMethod(string jsondata)
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                AttendeeFavorite[] eveval = serializer.Deserialize<AttendeeFavorite[]>(jsondata);

                if (InsertFavoriteAttendee(eveval) == 1)
                {


                    return "Successfully Updated..";
                }
                else
                {
                    return "Error occured while updating";
                }
            }
            catch (Exception Exception)
            {

            }

            return "Error occured while updating";
        }





        private static int InsertFavoriteAttendee(AttendeeFavorite[] favAttendee)
        {
            SqlCommand cmd = null;
            SqlConnection connect = null;

            try
            {
                string strCon = null;
                if (connect == null)
                {
                    strCon = System.Configuration.ConfigurationManager.ConnectionStrings["RemoteConnect"].ToString();
                    connect = new SqlConnection(strCon);
                    connect.Open();
                }
                ///Getting uploded image and its MIME type 
                if (favAttendee != null)
                {
                    int retvalue = 0;
                    for (int i = 0; i < favAttendee.Length; i++)
                    {
                        cmd = new SqlCommand();
                        cmd.CommandText = "Proc_events_InsertFavoriteAttendee";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = connect;
                        SqlParameter outputIdParam = new SqlParameter("@P_OutPara", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.AddWithValue("@p_id", favAttendee[i].ID);
                        cmd.Parameters.AddWithValue("@p_ucode", favAttendee[i].Ucode);
                        cmd.Parameters.AddWithValue("@p_attendeeid", favAttendee[i].AttendeeId);
                        cmd.Parameters.AddWithValue("@p_flag", favAttendee[i].Flag);
                        cmd.Parameters.Add(outputIdParam);
                        retvalue = cmd.ExecuteNonQuery();
                    }
                    return retvalue;
                }
                else
                {
                    return -1;
                }
            }
            catch (SqlException ex)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message:-" + ex.Message + "/r/n Error Log Status:-" + ex.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().ToString());
            }
            finally
            {

                cmd = null;
                connect.Close();
                connect = null;
            }

            return 1;
        }


        [WebMethod]

        public static String FavoriteExhibitorMethod(string jsondata)
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ExhibitorFavorite[] eveval = serializer.Deserialize<ExhibitorFavorite[]>(jsondata);

                if (InsertFavoriteExhi(eveval) == 1)
                {
                    return "Successfully Updated..";
                }
                else
                {
                    return "Error occured while updating";
                }
            }
            catch (Exception Exception)
            {
            }

            return "Error occured while updating";
        }

        private static int InsertFavoriteExhi(ExhibitorFavorite[] favAttendee)
        {
            SqlCommand cmd = null;
            SqlConnection connect = null;
            try
            {
                string strCon = null;
                if (connect == null)
                {
                    strCon = System.Configuration.ConfigurationManager.ConnectionStrings["RemoteConnect"].ToString();

                    connect = new SqlConnection(strCon);
                    connect.Open();
                }
                ///Getting uploded image and its MIME type 
                if (favAttendee != null)
                {
                    int retvalue = 0;
                    for (int i = 0; i < favAttendee.Length; i++)
                    {
                        cmd = new SqlCommand();
                        cmd.CommandText = "Proc_events_InsertFavoriteExhibitors";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = connect;
                        SqlParameter outputIdParam = new SqlParameter("@P_OutPara", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.AddWithValue("@p_id", favAttendee[i].ID);
                        cmd.Parameters.AddWithValue("@p_ucode", favAttendee[i].Ucode);
                        cmd.Parameters.AddWithValue("@p_attendeeid", favAttendee[i].ExhibitorId);
                        cmd.Parameters.AddWithValue("@p_flag", favAttendee[i].Flag);
                        cmd.Parameters.Add(outputIdParam);
                        retvalue = cmd.ExecuteNonQuery();
                    }
                    return retvalue;
                }
                else
                {
                    return -1;
                }
            }
            catch (SqlException ex)
            {
                //  Response.Write(ex.Message);
                // ObjError.WriteLog("Error Message:-" + ex.Message + "/r/n Error Log Status:-" + ex.StackTrace, ErrorLog.LogType.ErrorLog, ObjStack.GetMethod().ToString());
            }
            finally
            {

                cmd = null;
                connect.Close();
                connect = null;
            }

            return 1;
        }

        [WebMethod]

        public static String FavoriteSpeakerMethod(string jsondata)
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                SpeakerFavorite[] eveval = serializer.Deserialize<SpeakerFavorite[]>(jsondata);

                if (InsertFavoriteSpeaker(eveval) == 1)
                {
                    return "Successfully Updated..";
                }
                else
                {
                    return "Error occured while updating";
                }
            }
            catch (Exception Exception)
            {
            }
            return "Error occured while updating";
        }



        [WebMethod]
        public static String saveSpeakerMessage(string jsondata)
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                SpeakerMessage[] eveval = serializer.Deserialize<SpeakerMessage[]>(jsondata);
                if (SaveSpeakerMessageTrans(eveval) == 1)
                {
                    return "Successfully Updated..";
                }
                else
                {
                    return "Error occured while updating";
                }
            }
            catch (Exception Exception)
            {

            }
            return "Error occured while updating";
        }

        private static int SaveSpeakerMessageTrans(SpeakerMessage[] attendeeMsg)
        {

            try
            {

                ///Getting uploded image and its MIME type 
                if (attendeeMsg != null)
                {
                    int retvalue = 0;
                    for (int i = 0; i < attendeeMsg.Length; i++)
                    {
                        SqlCommand cmd = null;
                        SqlConnection connect = null;
                        string strCon = null;
                        if (connect == null)
                        {
                            strCon = System.Configuration.ConfigurationManager.ConnectionStrings["RemoteConnect"].ToString();
                            connect = new SqlConnection(strCon);
                            connect.Open();
                        }

                        cmd = new SqlCommand();
                        cmd.CommandText = "Proc_events_InsertSpeakerMessages";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = connect;
                        SqlParameter outputIdParam = new SqlParameter("@P_OutPara", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.AddWithValue("@p_id", attendeeMsg[i].ID);
                        cmd.Parameters.AddWithValue("@p_fromid", attendeeMsg[i].FromId);
                        cmd.Parameters.AddWithValue("@p_toid", attendeeMsg[i].ToId);
                        cmd.Parameters.AddWithValue("@p_messagetext", attendeeMsg[i].MessageText);
                        cmd.Parameters.AddWithValue("@p_messagedate", DateTime.Parse(attendeeMsg[i].MessageDate).ToString("yyyy/MM/dd hh:mm:ss"));
                        cmd.Parameters.AddWithValue("@p_flag", attendeeMsg[i].Flag);
                        cmd.Parameters.AddWithValue("@p_mode", 0);
                        cmd.Parameters.Add(outputIdParam);
                        retvalue = cmd.ExecuteNonQuery();
                        cmd = null;
                        connect.Close();
                        connect = null;
                    }
                    return retvalue;
                }
                else
                {
                    return -1;
                }
            }
            catch (SqlException ex)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message:-" + ex.Message + "/r/n Error Log Status:-" + ex.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().ToString());
            }
            finally
            {

            }
            return 1;
        }

        //[WebMethod]
        //public static string DeleteSendSpeakerMessage(int ID)
        //{
        //    try
        //    {
        //        JavaScriptSerializer serializer = new JavaScriptSerializer();
        //        //AttendeeCheckIn[] attendeeChekin = serializer.Deserialize<AttendeeCheckIn[]>(jsondata);
        //        //if (InsertAttendee(attendeeChekin) == 1)
        //        String query = "delete from event_New_tbl_SpeakerMessages where id =" + ID + "";
        //        SqlConnection objCon = GetConnection();
        //        SqlCommand cmd = new SqlCommand(query, objCon);
        //        int rVal = cmd.ExecuteNonQuery();

        //        if (rVal == 1)
        //        {
        //            return "Successfully deleted..";
        //        }
        //        else
        //        {
        //            return "Error occured while deleting";
        //        }
        //    }
        //    catch (Exception exception)
        //    {
        //        StackFrame objStack = new StackFrame();
        //        ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
        //    }
        //    return "Error occured while deleting";
        //}


        [WebMethod]
        public static string DeleteReceivedAttendeeMessage(int ID)
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                //AttendeeCheckIn[] attendeeChekin = serializer.Deserialize<AttendeeCheckIn[]>(jsondata);
                //if (InsertAttendee(attendeeChekin) == 1)
                String query = "delete from event_New_tbl_AttendeeMessages where id =" + ID + "";
                SqlConnection objCon = GetConnection();
                SqlCommand cmd = new SqlCommand(query, objCon);
                int rVal = cmd.ExecuteNonQuery();

                if (rVal == 1)
                {
                    return "Successfully deleted..";
                }
                else
                {
                    return "Error occured while deleting";
                }
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
            }
            return "Error occured while deleting";
        }


        [WebMethod]
        public static String saveExhibitorMessage(string jsondata)
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ExhibitorMessage[] eveval = serializer.Deserialize<ExhibitorMessage[]>(jsondata);
                if (SaveExhiMessageTrans(eveval) == 1)
                {
                    return "Successfully Updated..";
                }
                else
                {
                    return "Error occured while updating";
                }
            }
            catch (Exception Exception)
            {
            }
            return "Error occured while updating";
        }

        private static int SaveExhiMessageTrans(ExhibitorMessage[] attendeeMsg)
        {

            try
            {

                ///Getting uploded image and its MIME type 
                if (attendeeMsg != null)
                {
                    int retvalue = 0;
                    for (int i = 0; i < attendeeMsg.Length; i++)
                    {
                        SqlCommand cmd = null;
                        SqlConnection connect = null;
                        string strCon = null;
                        if (connect == null)
                        {
                            strCon = System.Configuration.ConfigurationManager.ConnectionStrings["RemoteConnect"].ToString();
                            connect = new SqlConnection(strCon);
                            connect.Open();
                        }
                        cmd = new SqlCommand();
                        cmd.CommandText = "Proc_events_InsertExhibitorMessages";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = connect;
                        SqlParameter outputIdParam = new SqlParameter("@P_OutPara", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.AddWithValue("@p_id", attendeeMsg[i].ID);
                        cmd.Parameters.AddWithValue("@p_fromid", attendeeMsg[i].FromId);
                        cmd.Parameters.AddWithValue("@p_toid", attendeeMsg[i].ToId);
                        cmd.Parameters.AddWithValue("@p_messagetext", attendeeMsg[i].MessageText);
                        cmd.Parameters.AddWithValue("@p_messagedate", DateTime.Parse(attendeeMsg[i].MessageDate).ToString("yyyy/MM/dd hh:mm:ss"));
                        cmd.Parameters.AddWithValue("@p_flag", attendeeMsg[i].Flag);
                        cmd.Parameters.AddWithValue("@p_mode", 0);
                        cmd.Parameters.Add(outputIdParam);
                        retvalue = cmd.ExecuteNonQuery();
                        cmd = null;
                        connect.Close();
                        connect = null;
                    }
                    return retvalue;
                }
                else
                {
                    return -1;
                }
            }
            catch (SqlException ex)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message:-" + ex.Message + "/r/n Error Log Status:-" + ex.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().ToString());
            }
            finally
            {


            }

            return 1;
        }



        [WebMethod]
        public static String saveAttendeeMessage(string jsondata)
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                AttendeeMessage[] eveval = serializer.Deserialize<AttendeeMessage[]>(jsondata);

                if (SaveAttendeeMessageTrans(eveval) == 1)
                {
                    return "Successfully Updated..";
                }
                else
                {
                    return "Error occured while updating";
                }
            }
            catch (Exception Exception)
            {
            }
            return "Error occured while updating";
        }

        private static int SaveAttendeeMessageTrans(AttendeeMessage[] attendeeMsg)
        {


            SqlCommand cmd = null;
            SqlConnection connect = null;
            try
            {
                string strCon = null;
                if (connect == null)
                {
                    strCon = System.Configuration.ConfigurationManager.ConnectionStrings["RemoteConnect"].ToString();
                    connect = new SqlConnection(strCon);
                    connect.Open();
                }
                ///Getting uploded image and its MIME type 
                if (attendeeMsg != null)
                {
                    int retvalue = 0;



                    for (int i = 0; i < attendeeMsg.Length; i++)
                    {
                        cmd = new SqlCommand();
                        cmd.CommandText = "Proc_events_InsertAttendeeMessages";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = connect;
                        SqlParameter outputIdParam = new SqlParameter("@P_OutPara", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.AddWithValue("@p_id", attendeeMsg[i].ID);
                        cmd.Parameters.AddWithValue("@p_fromid", attendeeMsg[i].FromId);
                        cmd.Parameters.AddWithValue("@p_toid", attendeeMsg[i].ToId);
                        cmd.Parameters.AddWithValue("@p_messagetext", attendeeMsg[i].MessageText);
                        cmd.Parameters.AddWithValue("@p_fromName", attendeeMsg[i].FromName);
                        cmd.Parameters.AddWithValue("@p_toname", attendeeMsg[i].ToName);
                        cmd.Parameters.AddWithValue("@p_senderType", attendeeMsg[i].SenderType);
                        cmd.Parameters.AddWithValue("@p_messagedate", DateTime.Parse(attendeeMsg[i].MessageDate).ToString("yyyy/MM/dd hh:mm:ss"));
                        cmd.Parameters.AddWithValue("@p_flag", attendeeMsg[i].Flag);
                        cmd.Parameters.AddWithValue("@p_mode", 0);
                        cmd.Parameters.Add(outputIdParam);
                        retvalue = cmd.ExecuteNonQuery();

                    }
                    return retvalue;
                }
                else
                {
                    return -1;
                }
            }
            catch (SqlException ex)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message:-" + ex.Message + "/r/n Error Log Status:-" + ex.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().ToString());
            }
            finally
            {

                cmd = null;
                connect.Close();
                connect = null;
            }

            return 1;
        }



        [WebMethod]
        public static String EventEvaluationMethod(string jsondata)
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                EventEvaluation[] eveval = serializer.Deserialize<EventEvaluation[]>(jsondata);

                if (InsertEventEvaluation(eveval) == 1)
                {


                    return "Successfully Updated..";
                }
                else
                {
                    return "Error occured while updating";
                }
            }
            catch (Exception Exception)
            {

            }

            return "Error occured while updating";
        }

        [WebMethod]

        public static String FavoriteSessionMethod(string jsondata)
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                SessionFavorite[] eveval = serializer.Deserialize<SessionFavorite[]>(jsondata);
                if (InsertFavoriteSession(eveval) == 1)
                {
                    return "Successfully Updated..";
                }
                else
                {
                    return "Error occured while updating";
                }
            }
            catch (Exception Exception)
            {
            }
            return "Error occured while updating";
        }

        private static int InsertFavoriteSession(SessionFavorite[] favAttendee)
        {
            SqlCommand cmd = null;
            SqlConnection connect = null;

            try
            {
                string strCon = null;
                if (connect == null)
                {
                    strCon = System.Configuration.ConfigurationManager.ConnectionStrings["RemoteConnect"].ToString();

                    connect = new SqlConnection(strCon);
                    connect.Open();
                }
                ///Getting uploded image and its MIME type 
                if (favAttendee != null)
                {
                    int retvalue = 0;

                    for (int i = 0; i < favAttendee.Length; i++)
                    {

                        cmd = new SqlCommand();
                        cmd.CommandText = "Proc_events_InsertFavoriteSession";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = connect;

                        SqlParameter outputIdParam = new SqlParameter("@P_OutPara", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };

                        cmd.Parameters.AddWithValue("@p_id", favAttendee[i].ID);
                        cmd.Parameters.AddWithValue("@p_ucode", favAttendee[i].Ucode);
                        cmd.Parameters.AddWithValue("@p_attendeeid", favAttendee[i].SessionId);
                        cmd.Parameters.AddWithValue("@p_flag", favAttendee[i].Flag);
                        cmd.Parameters.Add(outputIdParam);
                        retvalue = cmd.ExecuteNonQuery();


                    }
                    return retvalue;
                }
                else
                {
                    return -1;
                }
            }
            catch (SqlException ex)
            {
                //  Response.Write(ex.Message);
                // ObjError.WriteLog("Error Message:-" + ex.Message + "/r/n Error Log Status:-" + ex.StackTrace, ErrorLog.LogType.ErrorLog, ObjStack.GetMethod().ToString());
            }
            finally
            {

                cmd = null;
                connect.Close();
                connect = null;
            }

            return 1;
        }


        private static int InsertEventEvaluation(EventEvaluation[] eveval)
        {
            try
            {
                ///Getting uploded image and its MIME type 
                if (eveval != null)
                {
                    int retvalue = 0;

                    for (int i = 0; i < eveval.Length; i++)
                    {
                        SqlCommand cmd = new SqlCommand();
                        SqlConnection connect = null;
                        string strCon = null;
                        if (connect == null)
                        {
                            strCon = System.Configuration.ConfigurationManager.ConnectionStrings["RemoteConnect"].ToString();

                            connect = new SqlConnection(strCon);
                            connect.Open();
                        }
                        cmd.CommandText = "Proc_events_InsertEventAnswers";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = connect;

                        SqlParameter outputIdParam = new SqlParameter("@P_OutPara", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };

                        cmd.Parameters.AddWithValue("@p_event_code", eveval[i].EventCode);
                        cmd.Parameters.AddWithValue("@p_attedeeId", eveval[i].AttendeeId);
                        cmd.Parameters.AddWithValue("@p_questionId", eveval[i].QuestionId);
                        cmd.Parameters.AddWithValue("@p_optionValue", eveval[i].OptionValue);
                        //cmd.Parameters.AddWithValue("@p_otherText", eveval[i].OtherText);
                        cmd.Parameters.Add(outputIdParam);

                        retvalue = cmd.ExecuteNonQuery();
                        cmd = null;
                        connect.Close();
                        connect = null;


                    }
                    return 1;
                }
                else
                {
                    return -1;
                }
            }
            catch (Exception ex)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message:-" + ex.Message + "/r/n Error Log Status:-" + ex.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().ToString());
            }
            finally
            {


            }

            return 1;
        }

        private static int InsertFavoriteSpeaker(SpeakerFavorite[] favAttendee)
        {
            SqlCommand cmd = null;
            SqlConnection connect = null;

            try
            {
                string strCon = null;
                if (connect == null)
                {
                    strCon = System.Configuration.ConfigurationManager.ConnectionStrings["RemoteConnect"].ToString();

                    connect = new SqlConnection(strCon);
                    connect.Open();
                }

                ///Getting uploded image and its MIME type 


                if (favAttendee != null)
                {
                    int retvalue = 0;

                    for (int i = 0; i < favAttendee.Length; i++)
                    {

                        cmd = new SqlCommand();
                        cmd.CommandText = "Proc_events_InsertFavoriteSpeaker";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = connect;
                        SqlParameter outputIdParam = new SqlParameter("@P_OutPara", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.AddWithValue("@p_id", favAttendee[i].ID);
                        cmd.Parameters.AddWithValue("@p_ucode", favAttendee[i].Ucode);
                        cmd.Parameters.AddWithValue("@p_attendeeid", favAttendee[i].SpeakerId);
                        cmd.Parameters.AddWithValue("@p_flag", favAttendee[i].Flag);
                        cmd.Parameters.Add(outputIdParam);
                        retvalue = cmd.ExecuteNonQuery();
                    }
                    return retvalue;
                }
                else
                {
                    return -1;
                }
            }
            catch (SqlException ex)
            {
                //  Response.Write(ex.Message);
                // ObjError.WriteLog("Error Message:-" + ex.Message + "/r/n Error Log Status:-" + ex.StackTrace, ErrorLog.LogType.ErrorLog, ObjStack.GetMethod().ToString());
            }
            finally
            {

                cmd = null;
                connect.Close();
                connect = null;
            }

            return 1;
        }




        [WebMethod]
        public static String DeleteNotification(string ID)
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                //AttendeeCheckIn[] attendeeChekin = serializer.Deserialize<AttendeeCheckIn[]>(jsondata);
                //if (InsertAttendee(attendeeChekin) == 1)
                String query = "delete from event_New_tbl_Notification where id =" + int.Parse(ID) + "";
                SqlConnection objCon = GetConnection();
                SqlCommand cmd = new SqlCommand(query, objCon);
                int rVal = cmd.ExecuteNonQuery();

                if (rVal == 1)
                {
                    return "Successfully Updated..";
                }
                else
                {
                    return "Error occured while updating";
                }
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);

            }
            return "Error occured while updating";
        }


        [WebMethod]
        public static String AttendeeCheckIn(string attendeeId, string ucode, string ecode, string date)
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                //AttendeeCheckIn[] attendeeChekin = serializer.Deserialize<AttendeeCheckIn[]>(jsondata);
                //if (InsertAttendee(attendeeChekin) == 1)
                if (InsertAttendee(attendeeId, ucode, ecode, date) == 1)
                {
                    return "Successfully Updated..";
                }
                else
                {
                    return "Error occured while updating";
                }
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);

            }
            return "Error occured while updating";
        }

        //public static int InsertAttendee(AttendeeCheckIn[] data)
        public static int InsertAttendee(string attendeeid, string ucode, string ecode, string date)
        {
            //if (data.Length > 0 && data.Length <= 1)
            if (ucode != null && ecode != null && date != null)
            {
                String Query = "select flag from event_New_tbl_attendeeCheckin where ucode='" + ucode + "' and id = (select MAX(id) from event_New_tbl_attendeeCheckin where ucode='" + ucode + "' and convert( varchar(12),logindatetime,105) = '" + DateTime.Parse(date).ToString("dd/MM/yyyy") + "') ";
                // String Query = "select flag from event_New_tbl_attendeeCheckin where ucode='" + ucode + "' and id = (select MAX(id) from event_New_tbl_attendeeCheckin where ucode='" + ucode + "') and date(Logindate) = " +  + "";
                DataSet Ds = GetDataSet(Query);
                int CheckInflag = 0;
                foreach (DataRow row in Ds.Tables[0].Rows)
                {
                    if (row["flag"].Equals(System.DBNull.Value))
                    {
                        CheckInflag = 0;
                    }
                    else if (row["flag"].ToString() == "Checkin")
                    {
                        CheckInflag = 1;

                    }
                    else if (row["flag"].ToString() == "Checkout")
                    {
                        CheckInflag = 2;
                    }

                }
                if (CheckInflag == 1)
                {
                    String query = "update event_New_tbl_attendeeCheckin set flag='Checkout' where attendeeid = " + int.Parse(attendeeid) + " and convert( varchar(12),logindatetime,105) = '" + DateTime.Parse(date).ToString("dd/MM/yyyy") + "'";
                    SqlConnection objCon = GetConnection();
                    SqlCommand cmd = new SqlCommand(query, objCon);
                    int rVal = cmd.ExecuteNonQuery();
                }
                if (CheckInflag == 2)
                {
                    String query = "update event_New_tbl_attendeeCheckin set flag='Checkin' where attendeeid = " + int.Parse(attendeeid) + " and convert( varchar(12),logindatetime,105) = '" + DateTime.Parse(date).ToString("dd/MM/yyyy") + "'";
                    SqlConnection objCon = GetConnection();
                    SqlCommand cmd = new SqlCommand(query, objCon);
                    int rVal = cmd.ExecuteNonQuery();
                }
                else if (CheckInflag == 0)
                {
                    String query = "insert into event_New_tbl_attendeeCheckin(attendeeid,ecode,ucode,logindatetime,flag)values(" + int.Parse(attendeeid) + ",'" + ecode + "','" + ucode + "','" + DateTime.Parse(date).ToString("yyyy/MM/dd hh:mm:ss") + "','Checkin')";
                    SqlConnection objCon = GetConnection();
                    SqlCommand cmd = new SqlCommand(query, objCon);
                    int rVal = cmd.ExecuteNonQuery();

                }

                return 1;


            }
            else
            {
                return -1;
            }

        }

        [WebMethod]
        public static String Updateprofile(string jsondata)
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                AttaindeeDetails[] emp = serializer.Deserialize<AttaindeeDetails[]>(jsondata);
                if (updateAttendee(emp) == 1)
                {
                    return "Successfully Updated..";
                }
                else
                {
                    return "Error occured while updating";
                }
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);

            }
            return "Error occured while updating";
        }

        private static int updateAttendee(AttaindeeDetails[] emp)
        {
            if (emp.Length > 0 && emp.Length <= 1)
            {


                String query = "update event_New_tbl_Attendee set event_code='" + emp[0].EventCode + "',attendeeLevel=" + emp[0].AttendeeLevel + ",Title='" + emp[0].Title + "',FirstName='" + emp[0].FirstName + "',LastName='" + emp[0].LastName + "',Position='" + emp[0].Position + "',CategoryIndustry='" + emp[0].Category + "',Address='" + emp[0].Address + "',phonenumber='" + emp[0].PhoneNo + "',email='" + emp[0].Email + "',biography='" + emp[0].Biography + "',website='" + emp[0].Website + "',company='" + emp[0].Company + "',MIMETYPE='" + emp[0].MIMEType + "' where id=" + emp[0].ID + " ";
                SqlConnection objCon = GetConnection();
                SqlCommand cmd = new SqlCommand(query, objCon);
                int rVal = cmd.ExecuteNonQuery();

                return 1;
            }
            else
            {
                return -1;
            }


        }



        [WebMethod]
        public static AttendeeMessage[] GetAttaindeeMessages(String attendeeid)
        {

            AttendeeMessage[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetSelectedAttendeeMessageList(attendeeid).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }

        }

        [WebMethod]
        public static SpeakerMessage[] GetSpeakerMessages(String attendeeid)
        {

            SpeakerMessage[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetSelectedSpeakerMessageList(attendeeid).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }

        }


        [WebMethod]
        public static ExhibitorMessage[] GetExhibitorMessages(String attendeeid)
        {

            ExhibitorMessage[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetSelectedExhibitorMessageList(attendeeid).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }

        }



        [WebMethod]
        public static AttaindeeDetails[] GetAttaindeeData(String eventCode)
        {

            AttaindeeDetails[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetEmployees(int.Parse(eventCode)).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }

        }
        [WebMethod]
        public static SessionDetails[] GetSessionData(int attendeeId)
        {

            SessionDetails[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetSessions(attendeeId).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }

        }

        // question Options
        [WebMethod]
        public static EventQuestionOptions[] GetEventQuestionsOptions()
        {

            EventQuestionOptions[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetEventQuestionOptions().ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }

        }
        private static List<EventQuestionOptions> GetEventQuestionOptions()
        {
            List<EventQuestionOptions> currentCategories = new List<EventQuestionOptions>();
            String Query = "SELECT [id] ,[questionid] ,[option1] ,[option2]  ,[option3] ,[option4] FROM [event_New_tbl_EvalOptions]";
            DataSet Ds = GetDataSet(Query);

            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                EventQuestionOptions Dt = new EventQuestionOptions();
                Dt.Id = Convert.ToInt16(row["ID"].ToString());
                Dt.Questionid = Convert.ToInt16(row["questionid"].ToString());
                Dt.Option1 = Convert.ToString(row["option1"].ToString());
                Dt.Option2 = Convert.ToString(row["option2"].ToString());
                Dt.Option3 = Convert.ToString(row["option3"].ToString());
                Dt.Option4 = Convert.ToString(row["option4"].ToString());

                currentCategories.Add(Dt);
            }
            return currentCategories;
        }

        //


        [WebMethod]
        public static EventQuestions[] GetEventQuestions(int AttendeeId)
        {

            EventQuestions[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetEventQuestion(AttendeeId).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }

        }
        private static List<EventQuestions> GetEventQuestion(int AttendeeId)
        {
            List<EventQuestions> currentCategories = new List<EventQuestions>();
            // String Query = "SELECT [id],[event_code],[sessionid],[questiontext]  FROM [event_new_tbl_EvalQuestion] where event_new_tbl_EvalQuestion.event_code='" + ecode + "'  and event_new_tbl_EvalQuestion.sessionid=0";
            DataSet Ds = GetDataSetFromSP("Proc_Events_QuestionSet", AttendeeId);//GetDataSet(Query);
            //DataSet Ds = GetDataSet(Query);

            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                EventQuestions Dt = new EventQuestions();
                Dt.Id = Convert.ToInt16(row["ID"].ToString());
                Dt.Question = Convert.ToString(row["questiontext"].ToString());
                Dt.EventCode = Convert.ToString(row["event_code"].ToString());
                Dt.SessionId = Convert.ToInt16(row["sessionid"].ToString());

                currentCategories.Add(Dt);
            }
            return currentCategories;
        }

        private static List<SessionDetails> GetSessions(int AttendeeId)
        {
            List<SessionDetails> currentCategories = new List<SessionDetails>();
            //  String Query = "Select * From event_New_tbl_Session order by id";
            DataSet Ds = GetDataSetFromSP("Proc_Events_SessionSet", AttendeeId);//GetDataSet(Query);
            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                SessionDetails Dt = new SessionDetails();
                Dt.ID = Convert.ToInt16(row["ID"].ToString());
                Dt.EventCode = Convert.ToString(row["event_code"].ToString());
                Dt.SessiontTitle = Convert.ToString(row["sessionTitle"].ToString());
                Dt.SessionDate = Convert.ToString(row["sessionDate"]);
                Dt.SessionStartTime = Convert.ToString(row["sessionStartTime"]).ToString();
                Dt.SessionFinishTime = Convert.ToString(row["sessionFinishTime"]).ToString();
                Dt.SessionLocation = Convert.ToString(row["sessionLocation"]).ToString();
                Dt.Overview = Convert.ToString(row["overview"]);
                Dt.SessionSpeakerFirstName = Convert.ToString(row["sessionSpeakerFname"]).ToString();
                // Dt.SessionSpeakerlastName = Convert.ToString(row["sessionspeakerLname"]).ToString();
                currentCategories.Add(Dt);
            }
            return currentCategories;
        }

        [WebMethod]
        public static AttendeeFavorite[] GetFavAttendee(String ucode)
        {
            AttendeeFavorite[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetFavAttendeeList(ucode).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }
        }


        private static List<ExhibitorMessage> GetSelectedExhibitorMessageList(String attendeeid)
        {
            List<ExhibitorMessage> currentCategories = new List<ExhibitorMessage>();
            String Query = "SELECT [id] ,[fromid],[toid],[messagetext],[flag],[messagedate] FROM [event_New_tbl_ExhibitorMessages] where event_New_tbl_ExhibitorMessages.fromid = '" + attendeeid + "'";
            DataSet Ds = GetDataSet(Query);
            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                ExhibitorMessage Dt = new ExhibitorMessage();
                lock (Dt)
                {
                    Dt.ID = Convert.ToInt16(row["id"].ToString());
                    Dt.ToId = Convert.ToInt16(row["toid"].ToString());
                    Dt.FromId = Convert.ToInt16(row["fromid"].ToString());
                    Dt.MessageText = Convert.ToString(row["messagetext"].ToString());
                    Dt.MessageDate = Convert.ToString(row["messagedate"].ToString());
                    Dt.Flag = Convert.ToString(row["flag"].ToString());
                }
                currentCategories.Add(Dt);
            }
            return currentCategories;
        }

        private static List<SpeakerMessage> GetSelectedSpeakerMessageList(String attendeeid)
        {
            List<SpeakerMessage> currentCategories = new List<SpeakerMessage>();
            String Query = "SELECT  [id],[fromid],[toid],[messagetext],[flag],[messagedate]  FROM [event_New_tbl_SpeakerMessages] where event_New_tbl_SpeakerMessages.fromid = '" + attendeeid + "'";
            DataSet Ds = GetDataSet(Query);
            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                SpeakerMessage Dt = new SpeakerMessage();
                lock (Dt)
                {
                    Dt.ID = Convert.ToInt16(row["id"].ToString());
                    Dt.ToId = Convert.ToInt16(row["toid"].ToString());
                    Dt.FromId = Convert.ToInt16(row["fromid"].ToString());
                    Dt.MessageText = Convert.ToString(row["messagetext"].ToString());
                    Dt.MessageDate = Convert.ToString(row["messagedate"].ToString());
                    Dt.Flag = Convert.ToString(row["flag"].ToString());
                }
                currentCategories.Add(Dt);
            }
            return currentCategories;
        }


        private static List<AttendeeMessage> GetSelectedAttendeeMessageList(String attendeeid)
        {
            List<AttendeeMessage> currentCategories = new List<AttendeeMessage>();
            String Query = "SELECT  [id],[fromid],[toid],[messagetext],[flag],[messagedate],[fromname],[toname],[sendertype] FROM [event_New_tbl_AttendeeMessages] where toid = '" + attendeeid + "' or fromid = '" + attendeeid + "'";
            DataSet Ds = GetDataSet(Query);
            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                AttendeeMessage Dt = new AttendeeMessage();
                lock (Dt)
                {
                    Dt.ID = Convert.ToInt16(row["id"].ToString());
                    Dt.ToId = Convert.ToInt16(row["toid"].ToString());
                    Dt.FromId = Convert.ToInt16(row["fromid"].ToString());
                    Dt.MessageText = Convert.ToString(row["messagetext"].ToString());
                    Dt.MessageDate = Convert.ToString(row["messagedate"].ToString());
                    Dt.Flag = Convert.ToString(row["flag"].ToString());
                    Dt.FromName = Convert.ToString(row["fromname"].ToString());
                    Dt.ToName = Convert.ToString(row["toname"].ToString());
                    Dt.SenderType = Convert.ToInt16(row["sendertype"].ToString());
                }
                currentCategories.Add(Dt);
            }
            return currentCategories;
        }

        private static List<AttendeeFavorite> GetFavAttendeeList(String ucode)
        {
            List<AttendeeFavorite> currentCategories = new List<AttendeeFavorite>();
            String Query = "SELECT * from event_New_tbl_FavoriteAttendeeTable where ucode = '" + ucode + "'";
            DataSet Ds = GetDataSet(Query);
            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                AttendeeFavorite Dt = new AttendeeFavorite();
                lock (Dt)
                {
                    Dt.ID = Convert.ToInt16(row["id"].ToString());
                    Dt.Ucode = Convert.ToString(row["ucode"].ToString());
                    Dt.AttendeeId = Convert.ToInt16(row["attendeeid"].ToString());
                    Dt.Flag = Convert.ToString(row["flag"].ToString());
                }
                currentCategories.Add(Dt);
            }
            return currentCategories;
        }


        [WebMethod]
        public static ExhibitorFavorite[] GetFavExhibitor(String ucode)
        {
            ExhibitorFavorite[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetFavExhibitorList(ucode).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }
        }

        private static List<ExhibitorFavorite> GetFavExhibitorList(String ucode)
        {
            List<ExhibitorFavorite> currentCategories = new List<ExhibitorFavorite>();
            String Query = "SELECT * from event_New_tbl_FavoriteExhiTable where ucode = '" + ucode + "'";
            DataSet Ds = GetDataSet(Query);
            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                ExhibitorFavorite Dt = new ExhibitorFavorite();
                lock (Dt)
                {
                    Dt.ID = Convert.ToInt16(row["id"].ToString());
                    Dt.Ucode = Convert.ToString(row["ucode"].ToString());
                    Dt.ExhibitorId = Convert.ToInt16(row["exhiid"].ToString());
                    Dt.Flag = Convert.ToString(row["flag"].ToString());
                    currentCategories.Add(Dt);
                }
            }
            return currentCategories;
        }
        // speaker to session list

        [WebMethod]
        public static SpeakerToSession[] GetSpeakerToSession()
        {
            SpeakerToSession[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetSpeakerToSessionList().ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }
        }

        private static List<SpeakerToSession> GetSpeakerToSessionList()
        {
            List<SpeakerToSession> currentCategories = new List<SpeakerToSession>();
            String Query = "SELECT  [id],[speakerid],[sessionid]  FROM [dbo].[event_New_tbl_SpeakerToSession]";
            DataSet Ds = GetDataSet(Query);
            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                SpeakerToSession Dt = new SpeakerToSession();
                lock (Dt)
                {
                    Dt.ID = Convert.ToInt16(row["id"].ToString());
                    Dt.SpeakerId = Convert.ToInt16(row["speakerid"].ToString());
                    Dt.SessionId = Convert.ToInt16(row["sessionid"].ToString());

                    currentCategories.Add(Dt);
                }
            }
            return currentCategories;
        }

        [WebMethod]
        public static SpeakerFavorite[] GetFavSpeaker(String ucode)
        {
            SpeakerFavorite[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetFavSpeakerList(ucode).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }
        }
        private static List<SpeakerFavorite> GetFavSpeakerList(String ucode)
        {
            List<SpeakerFavorite> currentCategories = new List<SpeakerFavorite>();
            String Query = "SELECT * from event_New_tbl_FavoriteSpeakerTable where ucode = '" + ucode + "'";
            DataSet Ds = GetDataSet(Query);

            foreach (DataRow row in Ds.Tables[0].Rows)
            {

                SpeakerFavorite Dt = new SpeakerFavorite();
                lock (Dt)
                {
                    Dt.ID = Convert.ToInt16(row["id"].ToString());
                    Dt.Ucode = Convert.ToString(row["ucode"].ToString());
                    Dt.SpeakerId = Convert.ToInt16(row["speakerid"].ToString());
                    Dt.Flag = Convert.ToString(row["flag"].ToString());
                    currentCategories.Add(Dt);
                }
            }
            return currentCategories;
        }

        [WebMethod]
        public static SponsorDetails[] GetSponsorData(int AttendeeId)
        {

            SponsorDetails[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetSponsor(AttendeeId).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }

        }

        private static List<SponsorDetails> GetSponsor(int AttendeeId)
        {
            List<SponsorDetails> currentCategories = new List<SponsorDetails>();
            DataSet Ds = GetDataSetFromSP("Proc_Events_SponsorSetNew", AttendeeId);//GetDataSet(Query);

            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                SponsorDetails Dt = new SponsorDetails();
                Dt.ID = Convert.ToInt16(row["id"].ToString());
                Dt.EventCode = Convert.ToString(row["eventcode"].ToString());
                Dt.SponsorName = Convert.ToString(row["sponsorname"].ToString());
                Dt.Discription = Convert.ToString(row["discription"].ToString());
                Dt.MIMEType = GetExtenstion(Convert.ToString(row["MIMEType"]).ToString());
                Dt.Product1 = Convert.ToString(row["p_url1"].ToString());
                Dt.Product2 = Convert.ToString(row["p_url2"].ToString());
                Dt.Product3 = Convert.ToString(row["p_url3"].ToString());
                Dt.Product4 = Convert.ToString(row["p_url4"].ToString());
                Dt.Product5 = Convert.ToString(row["p_url5"].ToString());
                Dt.FacebookURL = Convert.ToString(row["facebookurl"].ToString());
                Dt.YouTubeURL = Convert.ToString(row["youtubeurl"].ToString());
                Dt.TwitterURL = Convert.ToString(row["twitterurl"].ToString());
                Dt.Contactname = Convert.ToString(row["contactname"].ToString());
                Dt.Phone = Convert.ToString(row["phone"].ToString());
                Dt.Email = Convert.ToString(row["email"].ToString());
                Dt.Position = Convert.ToString(row["position"].ToString());
                Dt.Address = Convert.ToString(row["s_comp_AddressLine1"].ToString());
                Dt.AdminLink = Convert.ToString(row["Adminlink"]).ToString();
                Dt.Website = Convert.ToString(row["website"]).ToString();
                currentCategories.Add(Dt);
            }
            return currentCategories;
        }

        [WebMethod]
        public static void updateAttendeeStatus(String attendeeid, String attendeestatus)
        {
            String query = "update event_New_tbl_Attendee set checkin='" + attendeestatus + "' where id = " + attendeeid + " ";
            SqlConnection objCon = GetConnection();
            SqlCommand cmd = new SqlCommand(query, objCon);
            int rVal = cmd.ExecuteNonQuery();

        }
        [WebMethod]
        public static NotificationMessages[] GetNotificationMessages(String ecode)
        {

            NotificationMessages[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetNotification(ecode).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }
        }
        private static List<NotificationMessages> GetNotification(string ecode)
        {
            List<NotificationMessages> currentCategories = new List<NotificationMessages>();
            String Query = "SELECT  [id] ,[event_code] ,[message],[notificationdate] FROM [dbo].[event_New_tbl_Notification] where event_code='" + ecode + "' ";
            DataSet Ds = GetDataSet(Query);
            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                NotificationMessages Dt = new NotificationMessages();
                Dt.ID = Convert.ToInt16(row["id"].ToString());
                Dt.Message = Convert.ToString(row["message"].ToString());
                Dt.Time = Convert.ToString(row["notificationdate"].ToString());
                currentCategories.Add(Dt);
            }
            return currentCategories;
        }
        private static List<UserDetails> GetUser(String username, String password)
        {
            List<UserDetails> currentCategories = new List<UserDetails>();
            String Query = "Select * From event_App_User where appusername='" + username + "' and passcode ='" + password + "'order by id";

            DataSet Ds = GetDataSet(Query);

            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                UserDetails Dt = new UserDetails();
                Dt.ID = Convert.ToInt16(row["ID"].ToString());
                Dt.Username = Convert.ToString(row["appusername"].ToString());
                Dt.Password = Convert.ToString(row["passcode"].ToString());
                Dt.EventCode = Convert.ToString(row["event_code"].ToString());
                Dt.Title = Convert.ToString(row["title"].ToString());
                Dt.FirstName = Convert.ToString(row["fname"].ToString());
                Dt.LastName = Convert.ToString(row["lname"].ToString());
                Dt.ContactName = Convert.ToString(row["name"].ToString());
                Dt.UserType = Convert.ToString(row["usertype"].ToString());

                currentCategories.Add(Dt);
            }
            return currentCategories;
        }
        public static List<AttaindeeDetails> GetEmployees(int EventCode)
        {

            List<AttaindeeDetails> currentCategories = new List<AttaindeeDetails>();
            // String Query = "SELECT event_New_tbl_Attendee.ID,event_New_tbl_Event.event_code, event_New_tbl_Attendee.AttendeeLevel, event_New_tbl_Attendee.Address,event_New_tbl_Attendee.Title,  event_New_tbl_Attendee.FirstName,   event_New_tbl_Attendee.LastName,   event_New_tbl_Attendee.Position,    event_New_tbl_Attendee.CategoryIndustry,      event_New_tbl_Attendee.PhoneNumber,       event_New_tbl_Attendee.Email,        event_New_tbl_Attendee.Website,         tbl_company.CompanyName,         event_New_tbl_Attendee.fburl,         event_New_tbl_Attendee.twurl,         event_New_tbl_Attendee.linkedinurl,         event_New_tbl_Attendee.MIMEType,         event_New_tbl_Attendee.checkin,  event_New_tbl_Event.event_name,event_New_tbl_Attendee.Biography FROM         event_New_tbl_Attendee INNER JOIN  event_New_tbl_Event ON event_New_tbl_Attendee.event_code = event_New_tbl_Event.event_code inner join  tbl_company on event_New_tbl_Attendee.company = tbl_company.Comp_id ";            
            DataSet Ds = GetDataSetFromSP("Proc_Events_AttendeeSetNew", EventCode);//GetDataSet(Query);
            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                AttaindeeDetails Dt = new AttaindeeDetails();
                Dt.ID = Convert.ToInt16(row["ID"].ToString());
                Dt.EventCode = Convert.ToString(row["event_code"].ToString());
                Dt.AttendeeLevel = Convert.ToInt16(row["AttendeeLevel"].ToString());
                Dt.Title = Convert.ToString(row["Title"]);
                Dt.FirstName = Convert.ToString(row["FirstName"]).ToString();
                Dt.LastName = Convert.ToString(row["LastName"]).ToString();
                Dt.Position = Convert.ToString(row["Position"]).ToString();
                Dt.Company = Convert.ToString(row["A_company_Name"]);
                Dt.Category = Convert.ToString(row["CategoryIndustry"]).ToString();
                Dt.Address = Convert.ToString(row["Address"]).ToString();
                Dt.PhoneNo = Convert.ToString(row["PhoneNumber"]);
                Dt.Email = Convert.ToString(row["Email"]).ToString();
                Dt.Biography = Convert.ToString(row["Biography"]).ToString();
                Dt.Website = Convert.ToString(row["Website"]).ToString();
                Dt.Facebook = Convert.ToString(row["fburl"]).ToString();
                Dt.Twitter = Convert.ToString(row["twurl"]).ToString();
                Dt.LinkedIn = Convert.ToString(row["linkedinurl"]).ToString();
                Dt.MIMEType = GetExtenstion(Convert.ToString(row["MIMEType"]).ToString());
                Dt.Checkin = Convert.ToString(row["checkin"]).ToString();
                Dt.AdminLink = Convert.ToString(row["adminlink"]).ToString();
                //String RealMIME = Convert.ToString(row["MIMEtype"]).ToString();
                //if (!(row["AttendeeImage"].Equals(System.DBNull.Value)))
                //{
                //    imageData = (Byte[])(row["AttendeeImage"]);
                //    byteArrayToImage(imageData, Dt.ID, Dt.MIMEType, RealMIME, myDirAttendee);//, RealMIME);
                //}
                //else
                //    imageData = null;
                currentCategories.Add(Dt);
            }
            return currentCategories;
        }

        [WebMethod]
        public static Exhibitors[] GetExhibitorData(int AttendeeId)
        {

            Exhibitors[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetExhibitors(AttendeeId).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }

        }
        [WebMethod]
        public static SpeakerDetails[] GetSpeakerData(int attendeeId)
        {

            SpeakerDetails[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetSpeakers(attendeeId).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }

        }
        [WebMethod]
        public static TwitterLink[] GetTwitterLinking(string ecode)
        {

            TwitterLink[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetTwitterData(ecode).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }

        }


        [WebMethod]
        public static EventDetails[] GetEventData()
        {

            EventDetails[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetEvents().ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }

        }

        private static List<EventDetails> GetEvents()
        {
            List<EventDetails> currentCategories = new List<EventDetails>();
            String Query = "SELECT     event_New_tbl_Event.event_code, tbl_company.CompanyName, event_New_tbl_Event.req_user_id, event_New_tbl_Event.req_date,  event_New_tbl_Event.event_name, event_New_tbl_EventType.eventTypeName, event_New_tbl_EventLevel.EventLevel,  event_New_tbl_Event.event_start_Date, event_New_tbl_Event.event_map,event_New_tbl_Event.event_map1,event_New_tbl_Event.event_map2,event_New_tbl_Event.event_map3,event_New_tbl_Event.event_map4, event_New_tbl_Event.timeZone, event_New_tbl_Event.event_start_time, event_New_tbl_Event.event_end_Date,  event_New_tbl_Event.event_finish_time,event_New_tbl_Event.MIMEType,event_New_tbl_Event.MIMEType1,event_New_tbl_Event.MIMEType2,event_New_tbl_Event.MIMEType3,event_New_tbl_Event.MIMEType4,event_New_tbl_Event.mapkey,event_New_tbl_Event.longitude,event_New_tbl_Event.latitude   FROM         event_New_tbl_Event INNER JOIN  event_New_tbl_EventType ON event_New_tbl_Event.event_type = event_New_tbl_EventType.id INNER JOIN  event_New_tbl_EventLevel ON event_New_tbl_Event.event_level = event_New_tbl_EventLevel.id INNER JOIN  tbl_company ON event_New_tbl_Event.company_id = tbl_company.Comp_id";
            DataSet Ds = GetDataSet(Query);
            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                EventDetails Dt = new EventDetails();
                Dt.EventCode = Convert.ToString(row["event_code"].ToString());
                Dt.Company = Convert.ToString(row["CompanyName"].ToString());
                Dt.UserRequestId = Convert.ToString(row["req_user_id"].ToString());
                Dt.UserContactNo = Convert.ToString(row["req_date"]);
                Dt.UserEmail = Convert.ToString(row["event_name"]).ToString();
                Dt.RequestDate = Convert.ToString(DateTime.Parse(row["req_date"].ToString()).ToShortDateString()).ToString();// (row["req_date"]).ToString();
                Dt.EventName = Convert.ToString(row["event_name"]).ToString();
                Dt.EventType = Convert.ToString(row["eventTypeName"]);
                Dt.EventLevel = Convert.ToString(row["EventLevel"]).ToString();
                Dt.EventStartDate = Convert.ToString(DateTime.Parse(row["event_start_Date"].ToString()).ToShortDateString()).ToString();
                Dt.EventEndDate = Convert.ToString(DateTime.Parse(row["event_end_Date"].ToString()).ToShortDateString()).ToString();
                Dt.EventStartTime = Convert.ToString(row["event_start_time"]).ToString();
                Dt.EventEndTime = Convert.ToString(row["event_finish_time"]).ToString();
                Dt.TimeZone = Convert.ToString(row["timeZone"]).ToString();

                Dt.MIMEType = GetExtenstion(Convert.ToString(row["MIMEType"]).ToString());
                Dt.MIMEType1 = GetExtenstion(Convert.ToString(row["MIMEType1"]).ToString());
                Dt.MIMEType2 = GetExtenstion(Convert.ToString(row["MIMEType2"]).ToString());
                Dt.MIMEType3 = GetExtenstion(Convert.ToString(row["MIMEType3"]).ToString());
                Dt.MIMEType4 = GetExtenstion(Convert.ToString(row["MIMEType4"]).ToString());
                Dt.MapKey = Convert.ToString(row["mapkey"]).ToString();
                Dt.Latitude = Convert.ToDecimal(row["latitude"].ToString());
                Dt.Longitude = Convert.ToDecimal(row["longitude"].ToString());
                // ;
                //,event_New_tbl_Event.longitude,event_New_tbl_Event.latitude
                //String RealMIME = Convert.ToString(row["MIMEType"]).ToString();
                //String RealMIME1 = Convert.ToString(row["MIMEType1"]).ToString();
                //String RealMIME2 = Convert.ToString(row["MIMEType2"]).ToString();
                //String RealMIME3 = Convert.ToString(row["MIMEType3"]).ToString();
                //String RealMIME4 = Convert.ToString(row["MIMEType4"]).ToString();

                //if (!(row["event_map"].Equals(System.DBNull.Value)))
                //{
                //    imageData = (Byte[])(row["event_map"]);
                //    byteArrayToImage(imageData, Dt.EventCode + "1", Dt.MIMEType, RealMIME, myDirMap);//, RealMIME);
                //}

                //if (!(row["event_map1"].Equals(System.DBNull.Value)))
                //{
                //    imageData = (Byte[])(row["event_map1"]);
                //    byteArrayToImage(imageData, Dt.EventCode + "2", Dt.MIMEType, RealMIME, myDirMap);//, RealMIME);
                //}
                //if (!(row["event_map2"].Equals(System.DBNull.Value)))
                //{
                //    imageData = (Byte[])(row["event_map2"]);
                //    byteArrayToImage(imageData, Dt.EventCode + "3", Dt.MIMEType, RealMIME, myDirMap);//, RealMIME);
                //}
                //if (!(row["event_map3"].Equals(System.DBNull.Value)))
                //{
                //    imageData = (Byte[])(row["event_map3"]);
                //    byteArrayToImage(imageData, Dt.EventCode + "4", Dt.MIMEType, RealMIME, myDirMap);//, RealMIME);
                //}
                //if (!(row["event_map4"].Equals(System.DBNull.Value)))
                //{
                //    imageData = (Byte[])(row["event_map4"]);
                //    byteArrayToImage(imageData, Dt.EventCode + "5", Dt.MIMEType, RealMIME, myDirMap);//, RealMIME);
                //}

                //else
                //    imageData = null;
                currentCategories.Add(Dt);
            }
            return currentCategories;
        }


        private static List<TwitterLink> GetTwitterData(String eventcode)
        {
            List<TwitterLink> currentCategories = new List<TwitterLink>();
            String Query = "SELECT [id] ,[eventcode],[twitterlink], [twitteruserid] FROM [dbo].[event_New_tbl_twitterlink] where eventcode ='" + eventcode + "'   ";
            DataSet Ds = GetDataSet(Query);
            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                TwitterLink Dt = new TwitterLink();
                Dt.ID = Convert.ToInt16(row["id"].ToString());
                Dt.EventCode = Convert.ToString(row["eventcode"].ToString());
                Dt.Twitterlink = Convert.ToString(row["twitterlink"].ToString());
                Dt.TwitterID = Convert.ToString(row["twitteruserid"].ToString());

                currentCategories.Add(Dt);
            }
            return currentCategories;
        }

        private static List<SpeakerDetails> GetSpeakers(int attendeeId)
        {
            List<SpeakerDetails> currentCategories = new List<SpeakerDetails>();

            //
            DataSet Ds = GetDataSetFromSP("Proc_Events_SpeakerSetNew", attendeeId);//GetDataSet(Query);
            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                SpeakerDetails Dt = new SpeakerDetails();
                Dt.ID = Convert.ToInt16(row["ID"].ToString());
                Dt.EventCode = Convert.ToString(row["event_code"].ToString());
                Dt.Title = Convert.ToString(row["Title"].ToString());
                Dt.FirstName = Convert.ToString(row["FirstName"]);
                Dt.LastName = Convert.ToString(row["LastName"]).ToString();
                Dt.Company = Convert.ToString(row["A_company_Name"]).ToString();
                Dt.Position = Convert.ToString(row["Position"]).ToString();
                Dt.Category = Convert.ToString(row["categoryIndustry"]);
                Dt.Address = Convert.ToString(row["Address"]).ToString();
                Dt.PhoneNo = Convert.ToString(row["phoneno"]).ToString();
                Dt.Email = Convert.ToString(row["Email"]);
                Dt.Biography = Convert.ToString(row["Biography"]).ToString();
                Dt.Website = Convert.ToString(row["Website"].ToString());
                Dt.Facebook = Convert.ToString(row["fburl"]).ToString();
                Dt.Twitter = Convert.ToString(row["twurl"]).ToString();
                Dt.LinkedIn = Convert.ToString(row["linkedinurl"]).ToString();
                Dt.MimeType = GetExtenstion(Convert.ToString(row["MIMEtype"]).ToString());
                Dt.AdminLink = Convert.ToString(row["Adminlink"]).ToString();
                //String RealMIME = Convert.ToString(row["MIMEtype"]).ToString();
                //if (!(row["SpeakerImage"].Equals(System.DBNull.Value)))
                //{
                //    imageData = (Byte[])(row["SpeakerImage"]);
                //    byteArrayToImage(imageData, Dt.ID, Dt.MimeType, RealMIME, myDirSpeaker);//, RealMIME);
                //}
                //else
                //    imageData = null;
                currentCategories.Add(Dt);
            }
            return currentCategories;
        }
        [WebMethod]
        public static NewsDetails[] GetNewsData(int AttendeeId)
        {

            NewsDetails[] ad = null;
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ad = GetNews(AttendeeId).ToArray();
                return ad;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                return ad;

            }

        }
        private static List<NewsDetails> GetNews(int AttendeeId)
        {
            List<NewsDetails> currentCategories = new List<NewsDetails>();

            DataSet Ds = GetDataSetFromSP("Proc_Events_NewsSet", AttendeeId);

            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                NewsDetails Dt = new NewsDetails();
                Dt.ID = Convert.ToInt16(row["ID"].ToString());
                Dt.EventCode = Convert.ToString(row["event_code"].ToString());
                Dt.AttendeeLevel = Convert.ToString(row["attaindeeLevel"].ToString());
                Dt.AuthorName = Convert.ToString(row["authorName"]);
                Dt.NewsDate = Convert.ToString(row["newsdate"]).ToString();
                Dt.Short = Convert.ToString(row["short"]).ToString();
                Dt.Discription = Convert.ToString(row["description"]).ToString();
                Dt.NewsID = Convert.ToString(row["Newsid"]);
                Dt.Title = Convert.ToString(row["title"]).ToString();
                Dt.MIMETYPE = GetExtenstion(Convert.ToString(row["MIMEType"]).ToString());
                // String RealMIME = Convert.ToString(row["MIMEType"]).ToString();
                Dt.NewsTime = Convert.ToString(row["newstime"]).ToString();

                Dt.FileName = Convert.ToString(row["filename"]).ToString();
                Dt.FileExtension = Convert.ToString(row["fileextention"]).ToString();
                Dt.FileType = Convert.ToString(row["filetype"]).ToString();

                //if (!(row["newsimage"].Equals(System.DBNull.Value)))
                //{
                //    imageData = (Byte[])(row["newsimage"]);
                //    byteArrayToImage(imageData, Dt.ID, Dt.MIMETYPE, RealMIME, myDirNews);//, RealMIME);
                //}
                //else
                //    imageData = null;
                currentCategories.Add(Dt);
            }
            return currentCategories;
        }
        private static List<Exhibitors> GetExhibitors(int AttendeeId)
        {
            List<Exhibitors> currentCategories = new List<Exhibitors>();
            DataSet Ds = GetDataSetFromSP("Proc_Events_ExhibitiorSetNew", AttendeeId);

            foreach (DataRow row in Ds.Tables[0].Rows)
            {
                Exhibitors Dt = new Exhibitors();
                Dt.ID = Convert.ToInt16(row["ID"].ToString());
                Dt.EventCode = Convert.ToString(row["event_code"].ToString());
                Dt.Company = Convert.ToString(row["A_company_Name"].ToString());
                Dt.StandNo = Convert.ToInt16(row["standno"]);
                Dt.Category = Convert.ToString(row["category"]).ToString();
                Dt.Address = Convert.ToString(row["address"]).ToString();
                Dt.Phoneno = Convert.ToString(row["phoneno"]).ToString();
                Dt.Email = Convert.ToString(row["email"]);
                Dt.Biography = Convert.ToString(row["biography"]).ToString();
                Dt.Website = Convert.ToString(row["website"]).ToString();
                Dt.Contactname = Convert.ToString(row["contactname"]);
                Dt.Position = Convert.ToString(row["position"]).ToString();
                Dt.Sponsorshiplevel = Convert.ToInt16(row["sponsorshiplevel"].ToString());
                Dt.Facebook = Convert.ToString(row["fburl"]).ToString();
                Dt.Twitter = Convert.ToString(row["twurl"]).ToString();
                Dt.LinkedIn = Convert.ToString(row["linkedinurl"]).ToString();
                Dt.MIMEType = GetExtenstion(Convert.ToString(row["MIMEtype"]).ToString());
                Dt.Product1 = Convert.ToString(row["productURL1"]).ToString();
                Dt.Product2 = Convert.ToString(row["productURL2"]).ToString();
                Dt.Product3 = Convert.ToString(row["productURL3"]).ToString();
                Dt.Product4 = Convert.ToString(row["productURL4"]).ToString();
                Dt.Product5 = Convert.ToString(row["productURL5"]).ToString();
                Dt.MAPMIMEType = GetExtenstion(Convert.ToString(row["MAPMIMEType"]).ToString());
                Dt.AdminLink = Convert.ToString(row["Adminlink"]).ToString();
                //String RealMIME = Convert.ToString(row["MIMEtype"]).ToString();
                //if (!(row["exiImage"].Equals(System.DBNull.Value)))
                //{
                //    imageData = (Byte[])(row["exiImage"]);
                //    byteArrayToImage(imageData, Dt.ID, Dt.MIMEType, RealMIME, myDirExihibitor);//, RealMIME);
                //}
                //else
                //    imageData = null;
                currentCategories.Add(Dt);
            }
            return currentCategories;
        }


        private static String GetExtenstion(String MIMEType)
        {
            String extension = "";
            switch (MIMEType)
            {
                case "image/gif": extension = ".gif"; break;
                case "image/jpeg": extension = ".jpeg"; break;
                case "image/png": extension = ".png"; break;
                default: extension = ".png"; break;
            }

            return extension;
        }
        //private static void byteArrayToImage(byte[] byteArrayIn, object ID, string MiMe, string realMime, string myDir)
        //{
        //    System.Drawing.Image newImage;
        //    String extension = MiMe;
        //    string strFileName = "";

        //    if (!extension.Equals(""))
        //    {
        //        strFileName = myDir + ID.ToString() + extension;
        //    }
        //    if (byteArrayIn != null)
        //    {

        //        newImage = GetImage(byteArrayIn);
        //        SaveJpeg(strFileName, ID.ToString(), realMime, newImage, 100);

        //    }

        //}
        //private static System.Drawing.Image GetImage(byte[] byteArray)
        //{
        //    var stream = new MemoryStream(byteArray);
        //    return System.Drawing.Image.FromStream(stream);
        //}

        //public static void SaveJpeg(string path, object ID, string realMime, System.Drawing.Image img, int quality)
        //{
        //    if (!File.Exists(path))
        //    {
        //        EncoderParameter qualityParam = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, quality);

        //        ImageCodecInfo jpegCodec = GetEncoderInfo(realMime);
        //        EncoderParameters encoderParams = new EncoderParameters(1);
        //        encoderParams.Param[0] = qualityParam;
        //        System.IO.MemoryStream mss = new System.IO.MemoryStream();
        //        System.IO.FileStream fs = new System.IO.FileStream(path, System.IO.FileMode.Create, System.IO.FileAccess.ReadWrite);

        //        img.Save(mss, jpegCodec, encoderParams);
        //        byte[] matriz = mss.ToArray();
        //        fs.Write(matriz, 0, matriz.Length);
        //        mss.Close();
        //        fs.Close();
        //    }
        //}
        //private static ImageCodecInfo GetEncoderInfo(string mimeType)
        //{
        //    // Get image codecs for all image formats
        //    ImageCodecInfo[] codecs = ImageCodecInfo.GetImageEncoders();

        //    // Find the correct image codec
        //    for (int i = 0; i < codecs.Length; i++)
        //        if (codecs[i].MimeType == mimeType)
        //            return codecs[i];
        //    return null;
        //}


        public static SqlConnection GetConnection()
        {
            SqlConnection objCon = null;

            string strCon = null;
            try
            {
                if (objCon == null)
                {
                    strCon = System.Configuration.ConfigurationManager.ConnectionStrings["RemoteConnect"].ToString();
                    //strCon = "Data Source=202.125.45.14,25000;Initial Catalog=DB6326_intranet;User ID=DB6326_intranet;Password=intra1;";
                    objCon = new SqlConnection(strCon);
                    objCon.Open();
                }
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);

                objCon.Close();
                objCon = null;
            }

            finally
            {
                strCon = null;

            }
            return objCon;
        }
        public static DataSet GetDataSet(string strMySql)
        {
            DataSet objDs = new DataSet();
            SqlConnection objCon = null;
            SqlDataAdapter objDa = null;
            try
            {
                objCon = GetConnection();
                objDa = new SqlDataAdapter(strMySql, objCon);
                objDa.Fill(objDs);

            }
            catch (SqlException ex)
            {
                objDs = null;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);
                objDs = null;
            }
            finally
            {
                if (objCon != null)
                {
                    objCon.Close();
                    objDa = null;
                }
            }
            return objDs;
        }


        private static DataSet GetDataSetFromSP(String ProcedureName, int EventCode)
        {
            string sql = ProcedureName;
            DataSet ds = new DataSet();
            SqlConnection conn = GetConnection();
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = new SqlCommand(sql, conn);
                SqlParameter outputIdParam = new SqlParameter("@P_OutPara", SqlDbType.Int)
                {
                    Direction = ParameterDirection.Output
                };
                da.SelectCommand.Parameters.AddWithValue("@p_attendeeid", EventCode);
                da.SelectCommand.Parameters.Add(outputIdParam);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                da.Fill(ds);
            }
            catch (Exception e)
            {
                Console.WriteLine("Error: " + e);
            }
            finally
            {
                conn.Close();
            }
            return ds;
        }


        public static DataTable getDataTable(String query)
        {
            DataTable dt = null;
            SqlConnection objCon = null;
            objCon = GetConnection();

            try
            {
                //Instantiate a DataAdapter by passing the sqlStr and myConn.
                //now data is in raw form
                SqlDataAdapter dAdapter = new SqlDataAdapter(query, objCon);
                dt = new DataTable();
                dAdapter.Fill(dt);
                return dt;
            }
            catch (Exception exception)
            {
                StackFrame objStack = new StackFrame();
                ErrorLog.WriteLog("Error Message :- " + exception.Message + "\r\n" + "Error Stack Trace:- " + exception.StackTrace, ErrorLog.LogType.ErrorLog, objStack.GetMethod().Name);

            }
            return dt;
        }




        private bool CheckAlreadyPolled(string blockMode)
        {
            bool isPolled = false;
            //if the block mode of this Poll is by IP,, check in the DB whether a poll is already existing from this IP
            if (blockMode == Poll.BlockMode.IP_ADDRESS.ToString())
            {
                string ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                Poll objPoll = new Poll();
                int id = objPoll.SelectPollIP(int.Parse(hidPollID.Value), ip);
                if (id > 0) isPolled = true;
            }
            else if (blockMode == Poll.BlockMode.COOKIE.ToString()) //If block by Cookie read the cookie to see if there is an entry for this blog
            {
                if (Request.Cookies["Poll"] != null && Request.Cookies["Poll"]["ID"] != null)
                {
                    //the cookie will have comma seperated IDs of all the polls that already voted
                    string commaSeperatedPollIDs = Request.Cookies["Poll"]["ID"];
                    //split it with comma
                    string[] pollIDs = commaSeperatedPollIDs.Split(",".ToCharArray());
                    //and loop through each pollID to find whethere the current poll is already voted
                    foreach (string pID in pollIDs)
                    {
                        //if yes break
                        if (pID == hidPollID.Value)
                        {
                            isPolled = true;
                            break;
                        }
                    }
                }
            }

            return isPolled;
        }

        [WebMethod]
        public static string UpdatePollCount(int pID, int cID, string eventcode, int sessionid)
        {
            //int pollID = pID;
            //int choiceID = cID;
            //update the vote count of the selected choice
            Poll objPoll = new Poll();
            objPoll.UpdateChoiceVote(cID);

            //save the users IP address - to block repeated vote if the BlockMode is by IP address
            string ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            objPoll.InsertPollIP(pID, ip);

            //Save the poll ID in cookie - to block repeated vote if the BlockMode is by Cookie
            HttpCookie pollCookie;// = new HttpCookie("Poll");
            string valueToStore = ""; //we store the poll IDs as comma seperated values

            //the cookie already exists and some PollIDs are already there
            if (HttpContext.Current.Request.Cookies["Poll"] != null && HttpContext.Current.Request.Cookies["Poll"]["ID"] != null)
            {
                pollCookie = HttpContext.Current.Request.Cookies["Poll"];
                valueToStore = HttpContext.Current.Request.Cookies["Poll"]["ID"] + "," + pID.ToString(); //append the current PollID to the already existing Poll IDs after a comma
            }
            else //cookie not exists - create a new one and store the ID
            {
                pollCookie = new HttpCookie("Poll");
                valueToStore = pID.ToString();
            }
            pollCookie.Values["ID"] = valueToStore;
            pollCookie.Expires = DateTime.MaxValue; //this cookie will never expire
            HttpContext.Current.Response.Cookies.Add(pollCookie);

            //get the poll result
            DataSet dsPoll = objPoll.SelectPoll(pID, eventcode, sessionid);
            return getResultHTML(dsPoll);
        }

        private static string getResultHTML(DataSet dsPoll)
        {
            int totalVotes = int.Parse(dsPoll.Tables[1].Compute("Sum(VoteCount)", String.Empty).ToString());
            System.Text.StringBuilder sbResult = new System.Text.StringBuilder();

            foreach (DataRow dr in dsPoll.Tables[1].Rows)
            {
                decimal percentage = 0;
                if (totalVotes > 0)
                    percentage = decimal.Round((decimal.Parse(dr["VoteCount"].ToString()) / decimal.Parse(totalVotes.ToString())) * 100, MidpointRounding.AwayFromZero);

                string alt = dr["VoteCount"].ToString() + " votes out of " + totalVotes.ToString();

                sbResult.Append("<label class='poll-result'>").Append(dr["Choice"]).Append(" (").Append(dr["VoteCount"]).Append(" votes - ").Append(percentage).Append("%)</label>");
                sbResult.Append("<div class='poll-chart'><img src='images/red-bar.png' width='0%' val='").Append(percentage).Append("%' height='15px' alt='").Append(alt).Append("' title='").Append(alt).Append("' /> ").Append("</div>");
            }
            sbResult.Append("<div class='poll-total'>Total Votes: ").Append(totalVotes).Append("</div>");
            //sbResult.Append("</p>");
            return sbResult.ToString();
        }

        public bool ThumbnailCallback()
        {
            return false;
        }

        protected void btnprofileSaveNew_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                Object[] objArr = new Object[2];
                String Title = txttitle.Value;
                String Firstname = txtfname.Value;
                String LastName = txtlname.Value;
                String Position = txtposition.Value;
                String Address = txtAddress.Value;
                String Phone_Number = txtPhone.Value;
                String Category = txtpCategory.Value;
                String Email = txtEmailaddress.Value;
                String biography = txtbio.Value;
                //String aid = txttitle.Value;
                object userid = UserId.Value;
                String usertype = UserType.Value;
                System.Drawing.Image image = System.Drawing.Image.FromStream(FileUpload1.PostedFile.InputStream);
                using (System.Drawing.Image thumbnail = image.GetThumbnailImage(85, 125, new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailCallback), IntPtr.Zero))
                {
                    using (MemoryStream memoryStream = new MemoryStream())
                    {
                        if (FileUpload1.PostedFile.ContentType.Equals("image/jpeg"))
                        { thumbnail.Save(memoryStream, ImageFormat.Jpeg); }
                        if (FileUpload1.PostedFile.ContentType.Equals("image/png"))
                        { thumbnail.Save(memoryStream, ImageFormat.Png); }
                        if (FileUpload1.PostedFile.ContentType.Equals("image/bmp"))
                        { thumbnail.Save(memoryStream, ImageFormat.Bmp); }
                        if (FileUpload1.PostedFile.ContentType.Equals("image/gif"))
                        { thumbnail.Save(memoryStream, ImageFormat.Gif); }

                        Byte[] bytes = new Byte[memoryStream.Length];
                        memoryStream.Position = 0;
                        memoryStream.Read(bytes, 0, (int)bytes.Length);
                        string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                        objArr[0] = bytes;
                        objArr[1] = FileUpload1.PostedFile.ContentType;

                        String myDir = "";
                        if (usertype == "1") { myDir = myDirAttendee; }
                        else if (usertype == "2") { myDir = myDirExihibitor; }
                        else if (usertype == "3") { myDir = myDirSpeaker; }
                        else if (usertype == "4") { myDir = myDirSponsor; }
                        byteArrayToImage(bytes, userid, fileExtensions(FileUpload1.PostedFile.ContentType), FileUpload1.PostedFile.ContentType, myDir);//, RealMIME);

                        profileImage.ImageUrl = myDir + userid + fileExtensions(FileUpload1.PostedFile.ContentType);
                        profileImage.Visible = true;
                    }
                }




                SqlCommand cmd = new SqlCommand();
                SqlConnection connect = null;

                try
                {
                    string strCon = null;
                    if (connect == null)
                    {
                        strCon = System.Configuration.ConfigurationManager.ConnectionStrings["RemoteConnect"].ToString();

                        connect = new SqlConnection(strCon);
                        connect.Open();
                    }
                    cmd.CommandText = "Proc_events_UpdateAppUserFromApp";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = connect;

                    SqlParameter outputIdParam = new SqlParameter("@P_OutPara", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.AddWithValue("@p_id", userid);
                    cmd.Parameters.AddWithValue("@p_Title", txttitle.Value);
                    cmd.Parameters.AddWithValue("@p_FirstName", txtfname.Value);
                    cmd.Parameters.AddWithValue("@p_LastName", txtlname.Value);
                    cmd.Parameters.AddWithValue("@p_Position", txtposition.Value);
                    cmd.Parameters.AddWithValue("@p_Address", txtAddress.Value);
                    cmd.Parameters.AddWithValue("@p_PhoneNo", txtPhone.Value);
                    cmd.Parameters.AddWithValue("@p_Category", txtpCategory.Value);
                    cmd.Parameters.AddWithValue("@p_Email", txtEmailaddress.Value);
                    cmd.Parameters.AddWithValue("@p_Biography", txtbio.Value);
                    cmd.Parameters.AddWithValue("@p_contactname", txtContactName.Value);
                    cmd.Parameters.AddWithValue("@p_image", objArr[0]);
                    cmd.Parameters.AddWithValue("@p_name", txtContactName.Value);
                    cmd.Parameters.AddWithValue("@p_MIME", objArr[1]);


                    cmd.Parameters.Add(outputIdParam);
                    int result = cmd.ExecuteNonQuery();
                    if (result == 1)
                    {
                        newMethod();
                        String jscript =
                        @"<script language = 'javascript'>
                        getAttendeeLoaded();
                        getExibitorLoaded();
                        getSpeakerLoaded();
                        getSponsorLoaded();                       
                      </script>";
                        ClientScript.RegisterStartupScript(GetType(), "_jscript", jscript);
                    }
                    else
                    {
                        String jscript = @"<script language = 'javascript'> alert('Error in Updating App User!');</script>";
                        ClientScript.RegisterStartupScript(GetType(), "_jscript", jscript);
                    }
                }
                catch (Exception ex)
                {
                }
            }
            else
            {
                String jscript = @"<script language = 'javascript'> alert('Please Select Profile Image...!');</script>";
                ClientScript.RegisterStartupScript(GetType(), "_jscript", jscript);
            }
        }

        private void newMethod()
        {
            try
            {

                string sFileName = System.IO.Path.GetRandomFileName();
                //string sGenName = "example.appcache";

                //YOu could omit these lines here as you may
                //not want to save the textfile to the server
                //I have just left them here to demonstrate that you could create the text file 
                //  "C:\\inetpub\\wwwroot\\istageEvents\\EventApp\\Pages\\example.appcache"))
                //  String pathOfAppCacheFile = ConfigurationManager.AppSettings["pathOfAppCacheFile"];// "C:\\inetpub\\wwwroot\\istageEvents\\EventApp\\app.appcache";
                using (System.IO.StreamWriter SW = new System.IO.StreamWriter(myAppCacheFile))
                //using (System.IO.StreamWriter SW = new System.IO.StreamWriter(Server.MapPath("\\Pages\\example.appcache")))           
                {
                    SW.WriteLine("CACHE MANIFEST");
                    SW.WriteLine("CACHE:");
                    SW.WriteLine("#Version Date:" + DateTime.Now);
                    SW.WriteLine("");
                    SW.WriteLine("css/images/icons-18-white.png");
                    SW.WriteLine("css/images/icons-36-black.png");
                    SW.WriteLine("css/images/icons-36-white.png");
                    SW.WriteLine("css/images/icons-18-black.png");
                    SW.WriteLine("js/widgets.js");
                    SW.WriteLine("js/bubble.js");
                    SW.WriteLine("images/icon_twitter@2x.png");
                    SW.WriteLine("images/loading.gif");
                    SW.WriteLine("js/jquery.mobile-1.3.0.min.js");
                    SW.WriteLine("js/jquery-1.8.2.min.js");
                    SW.WriteLine("css/jquery.mobile-1.3.0.min.css");
                    SW.WriteLine("index.html");
                    SW.WriteLine("images/attendee.png");
                    SW.WriteLine("images/checking.png");
                    SW.WriteLine("images/close.gif");
                    SW.WriteLine("images/error.png");
                    SW.WriteLine("images/evaluation.png");
                    SW.WriteLine("images/event.png");
                    SW.WriteLine("images/exhibitor.png");
                    SW.WriteLine("images/loading.gif");
                    SW.WriteLine("images/map.png");
                    SW.WriteLine("images/survey_icon.jpg");
                    SW.WriteLine("images/my_profile.png");
                    SW.WriteLine("images/news.png");
                    SW.WriteLine("images/notification.png");
                    SW.WriteLine("images/personal_shedule.png");
                    SW.WriteLine("images/shedule.png");
                    SW.WriteLine("images/speaker.png");
                    SW.WriteLine("images/sponsor.png");
                    SW.WriteLine("images/success.png");
                    SW.WriteLine("images/twitter.png");
                    SW.WriteLine("images/warning.png");
                    SW.WriteLine("images/touch-icon-iphone.png");
                    SW.WriteLine("images/touch-icon-ipad.png");
                    SW.WriteLine("images/touch-icon-iphone4.png");
                    SW.WriteLine("images/touch-icon-ipad2.png");
                    SW.WriteLine("images/ajax-loader.gif");
                    SW.WriteLine("images/icons-18-white.png");
                    SW.WriteLine("images/icons-36-black.png");
                    SW.WriteLine("images/icons-36-white.png");
                    SW.WriteLine("images/icons-18-black.png");
                    SW.WriteLine("images/icons-18-white.png");
                    SW.WriteLine("images/images.jpg");
                    SW.WriteLine("css/jquery.toastmessage.css");
                    SW.WriteLine("js/iscroll.js");
                    SW.WriteLine("js/jquery.mobile.fixedToolbar.polyfill.js");
                    SW.WriteLine("css/jquery.mobile-1.3.1.css");
                    SW.WriteLine("js/jquery.mobile-1.0a3.min.js");
                    SW.WriteLine("css/style.css");
                    SW.WriteLine("css/jquery.mobile.css");
                    SW.WriteLine("js/jquery-1.7.1.min.js");
                    SW.WriteLine("js/jquery.mobile.js");
                    SW.WriteLine("css/jquery.tweet.css");
                    SW.WriteLine("js/jquery.tweet.js");
                    SW.WriteLine("otherfiles/help.pdf");

                    //DataTable dt = getDataTable("select id,MIMETYPE,AttendeeImage from event_New_tbl_Attendee order by id");

                    DataTable dtexhi = getDataTable("select id,ExhiImageMiMe,ExhiImage from event_App_User order by id");

                    foreach (DataRow row in dtexhi.Rows)
                    {
                        object id = Convert.ToInt32(row["id"].ToString());
                        if (!(row["ExhiImageMiMe"].Equals(System.DBNull.Value)) && !(row["ExhiImage"].Equals(System.DBNull.Value)))
                        {
                            String mimeType = row["ExhiImageMiMe"].ToString();
                            String Ext = fileExtensions(mimeType);
                            String imageName = id.ToString() + Ext;
                            SW.WriteLine("exhiMap/" + imageName);
                            imageData = (Byte[])(row["ExhiImage"]);
                            byteArrayToImage(imageData, id, Ext, mimeType, myExhiMap);//, RealMIME);


                        }

                    }


                    DataTable dt = getDataTable("select id,MIMETYPE,image from event_App_User where event_App_User.usertype=1 order by id");
                    foreach (DataRow row in dt.Rows)
                    {
                        object id = Convert.ToInt32(row["id"].ToString());
                        if (!(row["MIMEType"].Equals(System.DBNull.Value)) && !(row["image"].Equals(System.DBNull.Value)))
                        {
                            String mimeType = row["MIMEType"].ToString();
                            String Ext = fileExtensions(mimeType);
                            String imageName = id.ToString() + Ext;
                            SW.WriteLine("imagesattaindee/" + imageName);
                            imageData = (Byte[])(row["image"]);
                            byteArrayToImage(imageData, id, Ext, mimeType, myDirAttendee);//, RealMIME);


                        }

                    }
                    DataTable dt1 = getDataTable("select event_code,MIMETYPE,MIMETYPE1,MIMETYPE2,MIMETYPE3,MIMETYPE4,event_map,event_map1,event_map2,event_map3,event_map4 from event_New_tbl_Event order by event_code");

                    foreach (DataRow row in dt1.Rows)
                    {
                        object id = (object)(row[0].ToString());
                        if (!(row["MIMEType"].Equals(System.DBNull.Value)) && !(row["event_map"].Equals(System.DBNull.Value)))
                        {
                            String mimeType = row[1].ToString();
                            String Ext = fileExtensions(mimeType);
                            String imageName = id.ToString() + "1" + Ext;
                            SW.WriteLine("imagesMap/" + imageName);
                            imageData = (Byte[])(row["event_map"]);
                            byteArrayToImage(imageData, id + "1", Ext, mimeType, myDirMap);//, RealMIME);


                        }
                        if (!(row["MIMEType1"].Equals(System.DBNull.Value)) && !(row["event_map1"].Equals(System.DBNull.Value)))
                        {
                            String mimeType = row[1].ToString();
                            String Ext = fileExtensions(mimeType);
                            String imageName = id.ToString() + "2" + Ext;
                            SW.WriteLine("imagesMap/" + imageName);
                            imageData = (Byte[])(row["event_map1"]);
                            byteArrayToImage(imageData, id + "2", Ext, mimeType, myDirMap);//, RealMIME);


                        }
                        if (!(row["MIMEType2"].Equals(System.DBNull.Value)) && !(row["event_map2"].Equals(System.DBNull.Value)))
                        {
                            String mimeType = row[1].ToString();
                            String Ext = fileExtensions(mimeType);
                            String imageName = id.ToString() + "3" + Ext;
                            SW.WriteLine("imagesMap/" + imageName);
                            imageData = (Byte[])(row["event_map2"]);
                            byteArrayToImage(imageData, id + "3", Ext, mimeType, myDirMap);//, RealMIME);


                        }
                        if (!(row["MIMEType3"].Equals(System.DBNull.Value)) && !(row["event_map3"].Equals(System.DBNull.Value)))
                        {
                            String mimeType = row[1].ToString();
                            String Ext = fileExtensions(mimeType);
                            String imageName = id.ToString() + "4" + Ext;
                            SW.WriteLine("imagesMap/" + imageName);
                            imageData = (Byte[])(row["event_map3"]);
                            byteArrayToImage(imageData, id + "4", Ext, mimeType, myDirMap);//, RealMIME);


                        }
                        if (!(row["MIMEType4"].Equals(System.DBNull.Value)) && !(row["event_map4"].Equals(System.DBNull.Value)))
                        {
                            String mimeType = row[1].ToString();
                            String Ext = fileExtensions(mimeType);
                            String imageName = id.ToString() + "5" + Ext;
                            SW.WriteLine("imagesMap/" + imageName);
                            imageData = (Byte[])(row["event_map4"]);
                            byteArrayToImage(imageData, id + "5", Ext, mimeType, myDirMap);//, RealMIME);


                        }

                    }
                    DataTable dt2 = getDataTable("select id,MIMETYPE,newsimage from event_New_tbl_News order by id");

                    foreach (DataRow row in dt2.Rows)
                    {
                        object id = Convert.ToInt32(row["id"].ToString());
                        if (!(row["MIMEType"].Equals(System.DBNull.Value)) && !(row["newsimage"].Equals(System.DBNull.Value)))
                        {
                            String mimeType = row["MIMEType"].ToString();
                            String Ext = fileExtensions(mimeType);
                            String imageName = id.ToString() + Ext;
                            SW.WriteLine("imagesNews/" + imageName);
                            imageData = (Byte[])(row["newsimage"]);
                            byteArrayToImage(imageData, id, Ext, mimeType, myDirNews);//, RealMIME);


                        }

                    }

                    //DataTable dt3 = getDataTable("select id,MIMETYPE,exiImage from event_New_tbl_Exihibitor order by id");
                    DataTable dt3 = getDataTable("select id,MIMETYPE,image from event_App_User where event_App_User.usertype=2 order by id");

                    foreach (DataRow row in dt3.Rows)
                    {
                        object id = Convert.ToInt32(row["id"].ToString());
                        if (!(row["MIMEType"].Equals(System.DBNull.Value)) && !(row["image"].Equals(System.DBNull.Value)))
                        {
                            String mimeType = row["MIMEType"].ToString();
                            String Ext = fileExtensions(mimeType);
                            String imageName = id.ToString() + Ext;
                            SW.WriteLine("imagesExihibitor/" + imageName);
                            imageData = (Byte[])(row["image"]);
                            byteArrayToImage(imageData, id, Ext, mimeType, myDirExihibitor);//, RealMIME);


                        }

                    }
                    // DataTable dt4 = getDataTable("select id,MIMETYPE,SpeakerImage from event_New_tbl_Speaker order by id");
                    DataTable dt4 = getDataTable("select id,MIMETYPE,image from event_App_User where event_App_User.usertype=3 order by id");
                    foreach (DataRow row in dt4.Rows)
                    {
                        object id = Convert.ToInt32(row["id"].ToString());
                        if (!(row["MIMEType"].Equals(System.DBNull.Value)) && !(row["image"].Equals(System.DBNull.Value)))
                        {
                            String mimeType = row["MIMEType"].ToString();
                            String Ext = fileExtensions(mimeType);
                            String imageName = id.ToString() + Ext;
                            SW.WriteLine("imagesSpeaker/" + imageName);
                            imageData = (Byte[])(row["image"]);
                            byteArrayToImage(imageData, id, Ext, mimeType, myDirSpeaker);//, RealMIME);


                        }

                    }

                    DataTable dt5 = getDataTable("select id,MIMETYPE,image from event_App_User where event_App_User.usertype=4 order by id");
                    // DataTable dt5 = getDataTable("select id,MIMETYPE,simage from event_New_tbl_sponsor order by id");
                    foreach (DataRow row in dt5.Rows)
                    {
                        object id = Convert.ToInt32(row["id"].ToString());
                        if (!(row["MIMEType"].Equals(System.DBNull.Value)) && !(row["image"].Equals(System.DBNull.Value)))
                        {
                            String mimeType = row["MIMEType"].ToString();
                            String Ext = fileExtensions(mimeType);
                            String imageName = id.ToString() + Ext;
                            SW.WriteLine("imagesSponsor/" + imageName);
                            imageData = (Byte[])(row["image"]);
                            byteArrayToImage(imageData, id, Ext, mimeType, myDirSponsor);//, RealMIME);
                        }
                    }
                    SW.WriteLine("NETWORK:");
                    SW.WriteLine("*");
                    SW.WriteLine("FALLBACK:");
                    SW.WriteLine("index.aspx index.html");
                    SW.WriteLine("images/ images/images.jpg");
                    SW.Close();
                    DataTable dt6 = getDataTable("SELECT [id],[bannerimage],[contentType] FROM [evet_New_tbl_Banner]");
                    foreach (DataRow row in dt6.Rows)
                    {
                        object id = Convert.ToInt32(row["id"].ToString());
                        if (!(row["contentType"].Equals(System.DBNull.Value)) && !(row["bannerimage"].Equals(System.DBNull.Value)))
                        {
                            id = "acecqa-banner";
                            String Ext = ".jpg";
                            imageData = (Byte[])(row["bannerimage"]);
                            byteArrayToImage(imageData, id, Ext, "image/jpeg", myDirBanner);//, RealMIME);
                        }
                    }
                }
                
                //String jscript = @"<script language = 'javascript'> alert('Update successful..!');</script>";
                //ClientScript.RegisterStartupScript(GetType(), "_jscript", jscript);
             
                //System.IO.FileStream fs = null;
                //fs = System.IO.File.Open(Server.MapPath("/" +
                //         sFileName + ".appcache"), System.IO.FileMode.Open);
                //byte[] btFile = new byte[fs.Length];
                //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
                //fs.Close();
                //Response.AddHeader("Content-disposition", "attachment; filename=" +
                //                   sGenName);
                //Response.ContentType = "application/octet-stream";
                //Response.BinaryWrite(btFile);
                //Response.End();
            }
            catch (Exception ex)
            {
               // Show(ex.Message);
            }
        }



        private  void byteArrayToImage(byte[] byteArrayIn, object ID, string MiMe, string realMime, string myDir)
        {
            System.Drawing.Image newImage;
            String extension = MiMe;
            string strFileName = "";

            if (!extension.Equals(""))
            {
                strFileName = myDir + ID.ToString() + extension;
            }
            if (byteArrayIn != null)
            {

                newImage = GetImage(byteArrayIn);
                SaveJpeg(strFileName, ID.ToString(), realMime, newImage, 100);

            }

        }
        private static System.Drawing.Image GetImage(byte[] byteArray)
        {
            var stream = new MemoryStream(byteArray);
            return System.Drawing.Image.FromStream(stream);
        }

        public static void SaveJpeg(string path, object ID, string realMime, System.Drawing.Image img, int quality)
        {

            EncoderParameter qualityParam = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, quality);

            ImageCodecInfo jpegCodec = GetEncoderInfo(realMime);
            EncoderParameters encoderParams = new EncoderParameters(1);
            encoderParams.Param[0] = qualityParam;
            System.IO.MemoryStream mss = new System.IO.MemoryStream();
            System.IO.FileStream fs = new System.IO.FileStream(path, System.IO.FileMode.Create, System.IO.FileAccess.ReadWrite);

            img.Save(mss, jpegCodec, encoderParams);
            byte[] matriz = mss.ToArray();
            fs.Write(matriz, 0, matriz.Length);
            mss.Close();
            fs.Close();

        }
        private static ImageCodecInfo GetEncoderInfo(string mimeType)
        {
            // Get image codecs for all image formats
            ImageCodecInfo[] codecs = ImageCodecInfo.GetImageEncoders();

            // Find the correct image codec
            for (int i = 0; i < codecs.Length; i++)
                if (codecs[i].MimeType == mimeType)
                    return codecs[i];
            return null;
        }

        private string fileExtensions(string mimeType)
        {
            String extension;
            switch (mimeType.ToLower())
            {
                case "image/gif": extension = ".gif"; break;
                case "image/jpeg": extension = ".jpeg"; break;
                case "image/jpg": extension = ".jpg"; break;
                case "image/png": extension = ".png"; break;
                default: extension = ".jpeg"; break;
            }
            return extension;
        }
    }
}
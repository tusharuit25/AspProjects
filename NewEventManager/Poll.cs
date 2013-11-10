using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NewEventManager
{
    class Poll
    {
        Database db;

        /// <summary>
        /// ConString is the DB connection string specified in web.config
        /// </summary>
        public Poll()
        {
            db = DatabaseFactory.CreateDatabase("RemoteConnect");
        }


        /// <summary>
        /// Select poll by using ID
        /// </summary>
        /// <param name="pollID">ID of the poll to select.</param>
        public DataSet SelectPoll(int pollID, string eventcode, int sessionid)
        {
            return db.ExecuteDataSet("usp_poll_select", pollID, eventcode, sessionid);
        }

        /// <summary>
        /// Get a random active poll ID
        /// </summary>
        public int getRandomActivePollID(string eventcode, int sessionid)
        {
            object pollID = db.ExecuteScalar("usp_Poll_getRandomActive", eventcode, sessionid);
            return pollID == null ? 0 : int.Parse(pollID.ToString());
        }


        /// <summary>
        /// list all the polls
        /// </summary>
        public DataTable ListPoll()
        {
            return db.ExecuteDataSet("usp_poll_list").Tables[0];
        }

        /// <summary>
        /// Insert a poll and return the ID
        /// </summary>
        /// <param name="question"></param>
        /// <returns>PollID</returns>
        public int InsertPoll(string question, string blockMode, bool active, string eventcode, int sessionid, int speakerid)
        {
            object pollID = db.ExecuteScalar("usp_poll_insert", question, blockMode, active, eventcode, sessionid, speakerid);
            return pollID == null ? 0 : int.Parse(pollID.ToString());

        }

        /// <summary>
        /// Update the poll and return the number of rows affected
        /// </summary>
        /// <param name="pollID"></param>
        /// <param name="question"></param>
        /// <returns>Number of rows affected</returns>
        public int UpdatePoll(int pollID, string question, string blockMode, bool active)
        {
            return db.ExecuteNonQuery("usp_poll_update", pollID, question, blockMode, active);
        }

        /// <summary>
        /// Delete a poll by using ID
        /// </summary>
        /// <param name="pollID"></param>
        /// <returns>Number of rows affected</returns>
        public int DeletePoll(int pollID)
        {
            return db.ExecuteNonQuery("usp_poll_delete", pollID);
        }

        /// <summary>
        /// Insert choice of a poll
        /// </summary>
        /// <param name="pollID"></param>
        /// <param name="choice"></param>
        /// <returns>ID of the inserted choice</returns>
        public int InsertChoice(int pollID, string choice)
        {
            return db.ExecuteNonQuery("usp_PollChoices_insert", pollID, choice);
        }

        /// <summary>
        /// Update a choice by its ID
        /// </summary>
        /// <param name="pollChoiceID"></param>
        /// <param name="choice"></param>
        /// <returns>Number of rows affected</returns>
        public int UpdateChoice(int pollChoiceID, string choice)
        {
            return db.ExecuteNonQuery("usp_PollChoices_update", pollChoiceID, choice);
        }

        /// <summary>
        /// Delete multiple choices by IDs seperated by comma
        /// </summary>
        /// <param name="pollChoiceIDs">Comma seperated string of IDs</param>
        /// <returns>Number of rows affected</returns>
        public int DeleteChoice(int choiceID)
        {
            return db.ExecuteNonQuery("usp_PollChoices_delete", choiceID);
        }

        /// <summary>
        /// Update the vote count for a choice by its ID
        /// </summary>
        /// <returns>Number of rows affected</returns>
        public int UpdateChoiceVote(int pollChoiceID)
        {
            return db.ExecuteNonQuery("usp_PollChoices_vote", pollChoiceID);
        }

        /// <summary>
        /// Log the IP address of the user and the poll id
        /// </summary>
        /// <returns></returns>
        public int InsertPollIP(int pollID, string ip)
        {
            return db.ExecuteNonQuery("usp_PollIPs_insert", pollID, ip);
        }

        /// <summary>
        /// Select an entry by the IP address and the poll id
        /// </summary>
        /// <returns>Positive number if exists</returns>
        public int SelectPollIP(int pollID, string ip)
        {
            object id = db.ExecuteScalar("usp_PollIPs_select", pollID, ip);
            try { return id == null ? 0 : int.Parse(id.ToString()); }
            catch { return 0; }
        }
        public enum BlockMode
        {
            COOKIE = 1, IP_ADDRESS = 2, NONE = 3
        };
        public DataTable SelectEvent(int attendeeid)
        {
            return db.ExecuteDataSet("usp_Event_select",attendeeid).Tables[0];
        }
        public DataTable SelectSession(string eventcode)
        {
            return db.ExecuteDataSet("usp_Session_select", eventcode).Tables[0];
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class EventEvaluation
    {
        private int _id;
        private int _questionid;
        private int _attendeeid;
        private int _optionValue;
        private string _otherText;
        private string _eventCode;

        public EventEvaluation()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public int ID
        {
            get { return _id; }
            set { _id = value; }
        }
        public int AttendeeId
        {
            get { return _attendeeid; }
            set { _attendeeid = value; }
        }
        public int QuestionId
        {
            get { return _questionid; }
            set { _questionid = value; }
        }
        public int OptionValue
        {
            get { return _optionValue; }
            set { _optionValue = value; }
        }

        public string OtherText
        {
            get { return _otherText; }
            set { _otherText = value; }
        }
        public string EventCode
        {
            get { return _eventCode; }
            set { _eventCode = value; }
        }

    }
}
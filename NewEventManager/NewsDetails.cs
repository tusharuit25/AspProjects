using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class NewsDetails
    {
        public NewsDetails()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        private int _Id;
        private string _eventCode;
        private string _attaindeeLevel;
        private string _newsdate;
        private string _short;
        private string _description;
        private string _Newsid;
        private string _title;
        private string _newstime;
        private string _MIMEType;
        private string _authorName;
        private string _FileName;
        private string _FileExtension;
        private string _FileType;


        public string EventCode
        {
            get { return _eventCode; }
            set { _eventCode = value; }
        }
        public int ID
        {
            get { return _Id; }
            set { _Id = value; }
        }

        public string AttendeeLevel
        {
            get { return _attaindeeLevel; }
            set { _attaindeeLevel = value; }
        }

        public string NewsDate
        {
            get { return _newsdate; }
            set { _newsdate = value; }
        }
        public string NewsID
        {
            get { return _Newsid; }
            set { _Newsid = value; }
        }
        public string Short
        {
            get { return _short; }
            set { _short = value; }
        }
        public string Discription
        {
            get { return _description; }
            set { _description = value; }
        }
        public string Title
        {
            get { return _title; }
            set { _title = value; }
        }
        public string NewsTime
        {
            get { return _newstime; }
            set { _newstime = value; }
        }

        public string MIMETYPE
        {
            get { return _MIMEType; }
            set { _MIMEType = value; }
        }
        public string AuthorName
        {
            get { return _authorName; }
            set { _authorName = value; }
        }
        public string FileName
        {
            get { return _FileName; }
            set { _FileName = value; }
        }
        public string FileExtension
        {
            get { return _FileExtension; }
            set { _FileExtension = value; }
        }
        public string FileType
        {
            get { return _FileType; }
            set { _FileType = value; }
        }
    }
}
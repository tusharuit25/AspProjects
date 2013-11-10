using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class SpeakerDetails
    {
        private int id;
        private string _eventCode;
        private string _Title;
        private string _FirstName;
        private string _LastName;
        private string _Company;
        private string _Position;
        private string _Category;
        private string _Address;
        private string _PhoneNo;
        private string _Email;
        private string _Biography;
        private string _Website;
        private string _MimeType;
        private string _facebook;
        private string _twitter;
        private string _linkedIn;
        private string _adminlink;
        public string AdminLink
        {
            get { return _adminlink; }
            set { _adminlink = value; }
        }

        public string Facebook
        {
            get { return _facebook; }
            set { _facebook = value; }
        }

        public string Twitter
        {
            get { return _twitter; }
            set { _twitter = value; }
        }

        public string LinkedIn
        {
            get { return _linkedIn; }
            set { _linkedIn = value; }
        }

        public SpeakerDetails()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public int ID
        {
            get { return id; }
            set { id = value; }
        }
        public string MimeType
        {
            get { return _MimeType; }
            set { _MimeType = value; }
        }

        public string EventCode
        {
            get { return _eventCode; }
            set { _eventCode = value; }
        }

        public string FirstName
        {
            get { return _FirstName; }
            set { _FirstName = value; }
        }

        public string LastName
        {
            get { return _LastName; }
            set { _LastName = value; }
        }

        public string Email
        {
            get { return _Email; }
            set { _Email = value; }
        }
        public string Company
        {
            get { return _Company; }
            set { _Company = value; }
        }
        public string Title
        {
            get { return _Title; }
            set { _Title = value; }
        }
        public string Position
        {
            get { return _Position; }
            set { _Position = value; }
        }

        public string Category
        {
            get { return _Category; }
            set { _Category = value; }
        }
        public string Address
        {
            get { return _Address; }
            set { _Address = value; }
        }
        public string PhoneNo
        {
            get { return _PhoneNo; }
            set { _PhoneNo = value; }
        }
        public string Biography
        {
            get { return _Biography; }
            set { _Biography = value; }
        }
        public string Website
        {
            get { return _Website; }
            set { _Website = value; }
        }

    }

}
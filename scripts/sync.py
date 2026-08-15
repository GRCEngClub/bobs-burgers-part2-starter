"""Nightly sync. Runs on the office Mac mini at 11:00 PM.
Grabs the ShoreTab daily export from the business email and puts it in the bucket.
"""
import datetime
import email
import imaplib
import os

import boto3

BUCKET = os.environ.get("BB_BUCKET", "bobs-burgers-menu-and-exports")

def latest_export():
    box = imaplib.IMAP4_SSL("imap.example.com")
    box.login("bobsburgers.business@example.com", os.environ["BB_MAIL_PASS"])
    box.select("INBOX")
    _, ids = box.search(None, '(SUBJECT "ShoreTab daily export")')
    _, data = box.fetch(ids[0].split()[-1], "(RFC822)")
    msg = email.message_from_bytes(data[0][1])
    for part in msg.walk():
        if part.get_filename() and part.get_filename().endswith(".csv"):
            return part.get_payload(decode=True)

def main():
    today = datetime.date.today().isoformat()
    body = latest_export()
    boto3.client("s3").put_object(Bucket=BUCKET, Key=f"exports/sales-{today}.csv", Body=body)

if __name__ == "__main__":
    main()

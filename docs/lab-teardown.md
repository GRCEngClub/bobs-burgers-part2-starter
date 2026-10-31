# Lab teardown

Do this the same day you finish. Save the output in `evidence/teardown/`.

1. `terraform -chdir=terraform destroy`
2. Confirm nothing is left: `aws s3 ls`, `aws cloudtrail describe-trails`, `aws iam list-users`
3. Delete any access keys you created by hand
4. Check Billing > Bills (or Cost Explorer) and screenshot the month-to-date total
5. If this was a throwaway account, close it when your team is done with Part II

# Bob's Burgers: Halloween Rush (Part II)

This is the working repo for Part II of Nightmare on Compliant Street. Fork it or copy it into a new repo your team owns. Everything in here is fictional.

Read the Part II case file first. This README is just the map.

## Roles

| Role | Mostly owns |
|---|---|
| Junior GRC Analyst | `logs/`, interviews, the incident reconstruction, risk register, control matrix |
| GRC Engineer | policies, control matrix, which checks block a merge and which only warn, exceptions |
| Security Engineer | `terraform/`, `network/`, `.github/workflows/`, evidence generation |

Nobody merges their own pull request. A control is not done until someone else on the team has reviewed it and the checks are green.

## Ground rules

- **Use a throwaway AWS account** (a fresh sign-up on the Free plan is ideal). Never point this at an account you care about.
- **Set a budget alert before you apply anything.** Aim for $0. S3, CloudTrail's first trail, IAM, Budgets and Access Analyzer's external-access findings are all free or pennies for a lab this size.
- **Tear down when you are done** (`terraform destroy`, then confirm the bucket and trail are gone). Teardown proof is part of your evidence.
- Make your repo public if you want it in a portfolio. Rulesets and branch protection are free on public repos. Do not commit real account IDs, keys, or anything you would not put on a resume.
- Use any tools you like. Checkov, OPA/Conftest, tfsec/Trivy, pytest and gitleaks are all reasonable. Pick what your team can explain.

## Map

```
terraform/   Gene's AWS setup, as he left it
network/     Router config export from the restaurant
logs/        POS, router, back door, delivery app and S3 logs
samples/     One day's sales export, so you know what is in the bucket
scripts/     The nightly sync script
docs/        Your Part I work goes in docs/part1. Control matrix and risk register live here.
evidence/    Proof. Name files as described in evidence/README.md
policy/      Your policy-as-code
tests/       Your automated tests
```

## First hour

1. Read the case file and the Part I packet again if it has been a while.
2. Look at the git history in this repo. All of it.
3. Open an issue for each thing you decide to work on.

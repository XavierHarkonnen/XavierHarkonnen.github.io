MESSAGE := Automatic commit

# push changes to repository
.PHONY: commit
commit:
	git add .
	git commit -m "$(MESSAGE)"

# push changes to repository
.PHONY: push
push: commit
	git push origin $(BRANCH)

# pull changes from repository
.PHONY: pull
pull:
	git pull origin $(BRANCH)
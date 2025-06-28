.PHONY: post

UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
    SED_CMD := sed -i ''
    CLEAR_CMD := printf "\033c"
	OS_NAME := $(shell sw_vers -productName)
else
    SED_CMD := sed -i
    CLEAR_CMD := clear
	OS_NAME := $(shell lsb_release -s -d)
endif

all: post

post:
	@$(CLEAR_CMD)
	@echo "${OS_NAME} detected"
	@echo "What type of post do you want to create?"
	@echo "1. Blog Post"
	@echo "2. Book Review"
	@echo -n "Enter your choice (1/2): "; \
	read choice; \
	case $$choice in \
		1) \
			current_date=$$(date +%Y-%m-%d); \
			echo -n "Enter date (default: $$current_date): "; \
			read date; \
			date=$${date:-$$current_date}; \
			echo -n "Enter blog post title (required): "; \
			read title; \
			while [ -z "$$title" ]; do \
				echo "Blog post title is required."; \
				echo -n "Enter blog post title (required): "; \
				read title; \
			done; \
			filename=$$(echo $$title | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/_/g' | sed 's/__*/_/g').html; \
			cp template/blog-post.html posts/$$filename; \
			$(SED_CMD) 's/\[BLOG POST TITLE\]/'"$$title"'/g' posts/$$filename; \
			$(SED_CMD) 's/<h2>Blog Post Title<\/h2>/<h2>'"$$title"'<\/h2>/g' posts/$$filename; \
			$(SED_CMD) 's/<dd>Date Written<\/dd>/<dd>'"$$date"'<\/dd>/g' posts/$$filename; \
			blog_entry="        <dl>\n          <dt>$$date</dt>\n          <dd>\n            <a href=\"posts/$$filename\">$$title</a>\n          </dd>\n        </dl>"; \
			$(SED_CMD) "/<section class=\"booksAndBlog\">/a\\$$blog_entry" index.html; \
			echo "Created blog post: posts/$$filename"; \
			echo "Updated index.html with new blog entry"; \
			;; \
		2) \
			current_date=$$(date +%Y-%m-%d); \
			echo -n "Enter date (default: $$current_date): "; \
			read date; \
			date=$${date:-$$current_date}; \
			echo -n "Enter book name (required): "; \
			read book_name; \
			while [ -z "$$book_name" ]; do \
				echo "Book name is required."; \
				echo -n "Enter book name (required): "; \
				read book_name; \
			done; \
			echo -n "Enter author name (required): "; \
			read author_name; \
			while [ -z "$$author_name" ]; do \
				echo "Author name is required."; \
				echo -n "Enter author name (required): "; \
				read author_name; \
			done; \
			echo -n "Enter ISBN number (required): "; \
			read isbn; \
			while [ -z "$$isbn" ]; do \
				echo "ISBN number is required."; \
				echo -n "Enter ISBN number (required): "; \
				read isbn; \
			done; \
			echo -n "Enter category (F for Fiction, N for Non-Fiction): "; \
			read category; \
			while [ "$$category" != "F" ] && [ "$$category" != "N" ]; do \
				echo "Category must be F or N."; \
				echo -n "Enter category (F for Fiction, N for Non-Fiction): "; \
				read category; \
			done; \
			if [ "$$category" = "F" ]; then \
				category_text="Fiction"; \
			else \
				category_text="Non-Fiction"; \
			fi; \
			echo -n "Enter rating (0-5, can be decimal): "; \
			read rating; \
			while [ -z "$$rating" ] || ! echo "$$rating" | grep -q "^[0-5]\(\.[0-9]\+\)\?$$"; do \
				echo "Rating must be a number between 0 and 5 (can be decimal)."; \
				echo -n "Enter rating (0-5, can be decimal): "; \
				read rating; \
			done; \
			filename=$$(echo $$book_name | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/_/g' | sed 's/__*/_/g').html; \
			cp template/book-post.html posts/$$filename; \
			$(SED_CMD) 's/\[BOOK TITLE\]/'"$$book_name"'/g' posts/$$filename; \
			$(SED_CMD) 's/\[AUTHOR\]/'"$$author_name"'/g' posts/$$filename; \
			$(SED_CMD) 's/<h2>Book Title<\/h2>/<h2>'"$$book_name"'<\/h2>/g' posts/$$filename; \
			$(SED_CMD) 's/<dd>Author Name<\/dd>/<dd>'"$$author_name"'<\/dd>/g' posts/$$filename; \
			$(SED_CMD) 's/<dd>ISBN Number<\/dd>/<dd>'"$$isbn"'<\/dd>/g' posts/$$filename; \
			$(SED_CMD) 's/<dd>Fiction\/Non-Fiction<\/dd>/<dd>'"$$category_text"'<\/dd>/g' posts/$$filename; \
			$(SED_CMD) 's/<dd>\*\/5<\/dd>/<dd>'"$$rating"'\/5<\/dd>/g' posts/$$filename; \
			$(SED_CMD) 's/<dd>Day Month Year<\/dd>/<dd>'"$$date"'<\/dd>/g' posts/$$filename; \
			book_entry="        <dl>\n          <dt>$$date</dt>\n          <dd>\n            <a href=\"posts/$$filename\">$$book_name</a>\n            <br>\n            <span class=\"author\">$$author_name</span>\n            <br>\n            <span class=\"isbn\">ISBN: $$isbn</span>\n            <br>\n            <span class=\"rating\">$$rating/5</span>, $$category_text\n          </dd>\n        </dl>"; \
			$(SED_CMD) "/<section class=\"booksAndBlog\">/a\\$$book_entry" index.html; \
			echo "Created book review: posts/$$filename"; \
			echo "Updated index.html with new book entry"; \
			;; \
		*) \
			echo "Invalid choice. Please run 'make post' again."; \
			exit 1; \
			;; \
	esac
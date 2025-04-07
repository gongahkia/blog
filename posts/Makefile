.PHONY: post

all:post

post:
	@clear
	@echo "What type of post do you want to create?"
	@echo "1. Blog Post"
	@echo "2. Book Review"
	@read -p "Enter your choice (1/2): " choice; \
	case $$choice in \
		1) \
			current_date=$$(date +%Y-%m-%d); \
			read -p "Enter date (default: $$current_date): " date; \
			date=$${date:-$$current_date}; \
			read -p "Enter blog post title (required): " title; \
			while [ -z "$$title" ]; do \
				echo "Blog post title is required."; \
				read -p "Enter blog post title (required): " title; \
			done; \
			filename=$$(echo $$title | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/_/g' | sed 's/__*/_/g').html; \
			cp ./../template/blog-post.html $$filename; \
			sed -i 's/\[BLOG POST TITLE\]/'"$$title"'/g' $$filename; \
			sed -i 's/<h2>Blog Post Title<\/h2>/<h2>'"$$title"'<\/h2>/g' $$filename; \
			sed -i 's/<dd>Date Written<\/dd>/<dd>'"$$date"'<\/dd>/g' $$filename; \
			blog_entry="        <dl>\n          <dt>$$date</dt>\n          <dd>\n            <a href=\"posts/$$filename\">$$title</a>\n          </dd>\n        </dl>"; \
			sed -i "/<section class=\"booksAndBlog\">/a\\$$blog_entry" ./../index.html; \
			echo "Created blog post: $$filename"; \
			echo "Updated index.html with new blog entry"; \
			;; \
		2) \
			current_date=$$(date +%Y-%m-%d); \
			read -p "Enter date (default: $$current_date): " date; \
			date=$${date:-$$current_date}; \
			read -p "Enter book name (required): " book_name; \
			while [ -z "$$book_name" ]; do \
				echo "Book name is required."; \
				read -p "Enter book name (required): " book_name; \
			done; \
			read -p "Enter author name (required): " author_name; \
			while [ -z "$$author_name" ]; do \
				echo "Author name is required."; \
				read -p "Enter author name (required): " author_name; \
			done; \
			read -p "Enter ISBN number (required): " isbn; \
			while [ -z "$$isbn" ]; do \
				echo "ISBN number is required."; \
				read -p "Enter ISBN number (required): " isbn; \
			done; \
			read -p "Enter category (F for Fiction, N for Non-Fiction): " category; \
			while [ "$$category" != "F" ] && [ "$$category" != "N" ]; do \
				echo "Category must be F or N."; \
				read -p "Enter category (F for Fiction, N for Non-Fiction): " category; \
			done; \
			if [ "$$category" = "F" ]; then \
				category_text="Fiction"; \
			else \
				category_text="Non-Fiction"; \
			fi; \
			read -p "Enter rating (0-5, can be decimal): " rating; \
			while [ -z "$$rating" ] || ! echo "$$rating" | grep -q "^[0-5]\(\.[0-9]\+\)\?$$"; do \
				echo "Rating must be a number between 0 and 5 (can be decimal)."; \
				read -p "Enter rating (0-5, can be decimal): " rating; \
			done; \
			filename=$$(echo $$book_name | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/_/g' | sed 's/__*/_/g').html; \
			cp ./../template/book-post.html $$filename; \
			sed -i 's/\[BOOK TITLE\]/'"$$book_name"'/g' $$filename; \
			sed -i 's/\[AUTHOR\]/'"$$author_name"'/g' $$filename; \
			sed -i 's/<h2>Book Title<\/h2>/<h2>'"$$book_name"'<\/h2>/g' $$filename; \
			sed -i 's/<dd>Author Name<\/dd>/<dd>'"$$author_name"'<\/dd>/g' $$filename; \
			sed -i 's/<dd>ISBN Number<\/dd>/<dd>'"$$isbn"'<\/dd>/g' $$filename; \
			sed -i 's/<dd>Fiction\/Non-Fiction<\/dd>/<dd>'"$$category_text"'<\/dd>/g' $$filename; \
			sed -i 's/<dd>\*\/5<\/dd>/<dd>'"$$rating"'\/5<\/dd>/g' $$filename; \
			sed -i 's/<dd>Day Month Year<\/dd>/<dd>'"$$date"'<\/dd>/g' $$filename; \
			book_entry="        <dl>\n          <dt>$$date</dt>\n          <dd>\n            <a href=\"posts/$$filename\">$$book_name</a>\n            <br>\n            <span class=\"author\">$$author_name</span>\n            <br>\n            <span class=\"isbn\">ISBN: $$isbn</span>\n            <br>\n            <span class=\"rating\">$$rating/5</span>, $$category_text\n          </dd>\n        </dl>"; \
			sed -i "/<section class=\"booksAndBlog\">/a\\$$book_entry" ./../index.html; \
			echo "Created book review: $$filename"; \
			echo "Updated index.html with new book entry"; \
			;; \
		*) \
			echo "Invalid choice. Please run 'make post' again."; \
			exit 1; \
			;; \
	esac
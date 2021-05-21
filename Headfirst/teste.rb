

books = []

file = File.open("books.txt", "r")

while (book = file.gets)
    books << book
end

file.close
books.each {|l| puts l}


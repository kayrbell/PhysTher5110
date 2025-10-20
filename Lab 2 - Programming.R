# Task 1
num1 <- 15
num2 <- 7

sum_result <- num1 + num2
print(sum_result)
diff_result <- num1 - num2
print(diff_result)
prod_result <- num1 * num2
print(prod_result)
quotient_result <- num1 / num2
print(quotient_result)

print("Task 1 Results:")
print(paste("Sum:", sum_result))
print(paste("Difference:", diff_result))
print(paste("Product:", prod_result))
print(paste("Quotient:", quotient_result))


# Task 2
ages <- c(25, 30, 22, 40, 28)
print(ages)
print(mean(ages))
average_age <- mean(ages)
print(ages+5)
updated_ages <- ages + 5

print("\nTask 2 Results:")
print(paste("Average Age:", average_age))
print("Updated Ages:")
print(updated_ages)


# Task 3
temperature <- 28
temperature <- 27

if (temperature > 25) {
  print("It's a hot day!")
} else {
  print("It's a pleasant day!")
}


# Task 4
print("\nTask 4 Results:")
for(i in 1:10) {
  square <- i^2
  print(paste(i, ":", square))
}



# Task 5
calculate_area <- function(length, width) {
  area <- length * width
  return(area)
}

rectangle_length <- 8
rectangle_width <- 5

area_result <- calculate_area(rectangle_length, rectangle_width)
print(area_result)

print("\nTask 5 Results:")
print(paste("Area of Rectangle:", area_result))



# Task 6
students <- data.frame(
  name = character(0),
  grade = integer(0),
  score = numeric(0)
)
student_number <- 30
mean_alg <- 60
sd <- 10
mean_ari <- 75

student_names <- c("Alice", "Bob", "Charlie", "David", "Eva", "Frank", "Grace", "Hannah", "Ivan")
names <- c("Bella", "Steven", "Brent", "Adam", "Jeremiah", "Conrad", "Alex", "Cole", "Kenny", "Khris")
student_grades <- c("Sophomore", "Junior", "Senior")
grades <- c("Freshman", "Sophomore", "Junior")
algebra_scores <- rnorm(n = student_number, mean = mean_alg, sd = sd)
arithmetic_scores <- rnorm(n = student_number , mean = mean_ari, sd = sd) 
hist(algebra_scores)
hist(arithmetic_scores)

students2 <- data.frame(
  name = rep(names, length(student_grades)),
  grade = rep(student_grades, each = length(names)),
  algebra = algebra_scores,
  arithmetic = arithmetic_scores
)
test_score <- algebra_scores + arithmetic_scores

students3 <- data.frame(
   algebra_scores, arithmetic_scores,
  grade = rep(student_grades, each = length(names))
)
  
average_scores <- tapply(students$score, students$grade, mean)
print(average_scores)

plot(students3) +
geom_point(aes(x = grade, y = algebra_scores), color = "red", size = 3) +
geom_point(aes(x = grade, y = arithmetic_scores), color = "blue", size = 3)
xlab = grade
ylab = test_score

students3$grade <- as.numeric(students3$grade)

xlim <- range(students3$grade)
ylim <- range(students3$algebra_scores, students3$arithmetic_scores)

plot(students3$grade, students3$algebra_scores,
col = "red",
pch = 16,
xlab = "grade", 
ylab = "test_score",
ylim = ylim,
xlim = xlim)

points(students3$grade, students3$arithmetic_scores, 
       col = "blue",
       pch = 16)

correlation <- cor(students3$algebra_scores, students3$arithmetic_scores, use = "complete.obs")
ggplot(students3, aes(x = grade)) +
  geom_point(aes(y = algebra_scores), color = "red", size = 3) +
  geom_point(aes(y = arithmetic_scores), color = "blue", size = 3) +
  labs(x = "Grade", y = "Test Score") 
  
 
   
algebra_scores <- rnorm(n = student_number, mean = mean_alg, sd = sd)
arithmetic_scores <- rnorm(n = student_number , mean = mean_ari, sd = sd) + algebra_scores

ggplot(students3) + 
geom_point(aes(x = grade, y = algebra_scores), color = "red", size = 3) +
geom_point(aes(x = grade, y = arithmetic_scores), color = "blue", size = 3)
xlab = student_grades
ylab = test_score

-- Base de données pour la plateforme e-learning
CREATE DATABASE IF NOT EXISTS elearning_platform;
USE elearning_platform;

-- Table users
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('TRAINEE', 'TRAINER', 'ADMIN') DEFAULT 'TRAINEE',
    bio TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_role (role)
);

-- Table courses
CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    level ENUM('debutant', 'intermediaire', 'avance') DEFAULT 'debutant',
    category VARCHAR(100),
    thumbnail_url VARCHAR(500),
    created_by INT NOT NULL,
    is_published BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_category (category),
    INDEX idx_level (level),
    INDEX idx_created_by (created_by)
);

-- Table modules
CREATE TABLE modules (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    order_index INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    INDEX idx_course_order (course_id, order_index)
);

-- Table lessons
CREATE TABLE lessons (
    id INT PRIMARY KEY AUTO_INCREMENT,
    module_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    content_type ENUM('video', 'text', 'pdf', 'link') NOT NULL,
    content_url_or_text TEXT,
    order_index INT NOT NULL DEFAULT 0,
    estimated_duration_minutes INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (module_id) REFERENCES modules(id) ON DELETE CASCADE,
    INDEX idx_module_order (module_id, order_index)
);

-- Table quizzes
CREATE TABLE quizzes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    module_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (module_id) REFERENCES modules(id) ON DELETE CASCADE
);

-- Table questions
CREATE TABLE questions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    quiz_id INT NOT NULL,
    question_text TEXT NOT NULL,
    type ENUM('single_choice', 'multiple_choice', 'short_text') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

-- Table options
CREATE TABLE options (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question_id INT NOT NULL,
    option_text TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

-- Table enrollments
CREATE TABLE enrollments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('enrolled', 'completed') DEFAULT 'enrolled',
    final_score DECIMAL(5,2),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    UNIQUE KEY unique_enrollment (user_id, course_id),
    INDEX idx_user_course (user_id, course_id)
);

-- Table quiz_attempts
CREATE TABLE quiz_attempts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    quiz_id INT NOT NULL,
    score DECIMAL(5,2),
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE,
    INDEX idx_user_quiz (user_id, quiz_id)
);

-- Table quiz_answers
CREATE TABLE quiz_answers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    quiz_attempt_id INT NOT NULL,
    question_id INT NOT NULL,
    selected_option_id INT NULL,
    answer_text TEXT,
    is_correct BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quiz_attempt_id) REFERENCES quiz_attempts(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE,
    FOREIGN KEY (selected_option_id) REFERENCES options(id) ON DELETE SET NULL
);

-- Table progress
CREATE TABLE progress (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    lesson_id INT NOT NULL,
    status ENUM('not_started', 'in_progress', 'completed') DEFAULT 'not_started',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE,
    UNIQUE KEY unique_progress (user_id, lesson_id),
    INDEX idx_user_lesson (user_id, lesson_id)
);

-- Table chatbot_sessions
CREATE TABLE chatbot_sessions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    course_id INT NULL,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_activity_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE SET NULL,
    INDEX idx_user (user_id)
);

-- Table chatbot_messages
CREATE TABLE chatbot_messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT NOT NULL,
    sender ENUM('user', 'bot') NOT NULL,
    message_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (session_id) REFERENCES chatbot_sessions(id) ON DELETE CASCADE,
    INDEX idx_session (session_id)
);

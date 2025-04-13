-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Apr 13, 2025 at 10:59 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `speakspace`
--

-- --------------------------------------------------------

--
-- Table structure for table `chatmessages`
--

CREATE TABLE `chatmessages` (
  `message_id` int(11) NOT NULL,
  `session_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chatmessages`
--

INSERT INTO `chatmessages` (`message_id`, `session_id`, `user_id`, `message`, `timestamp`) VALUES
(1, 1, 9, 'This session is amazing!', '2025-04-12 18:14:32'),
(2, 2, 11, 'Can you explain that again?', '2025-04-12 18:14:32'),
(3, 3, 15, 'Loved the topic!', '2025-04-12 18:14:32'),
(4, 4, 17, 'Very helpful content.', '2025-04-12 18:14:32'),
(5, 5, 13, 'Great explanation.', '2025-04-12 18:14:32'),
(6, 6, 9, 'Looking forward to the next session.', '2025-04-12 18:14:32'),
(7, 7, 14, 'How do I access the slides?', '2025-04-12 18:14:32'),
(8, 8, 8, 'I have a question.', '2025-04-12 18:14:32'),
(9, 9, 9, 'Excellent delivery!', '2025-04-12 18:14:32'),
(10, 10, 15, 'Very interactive!', '2025-04-12 18:14:32');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL,
  `session_id` int(11) DEFAULT NULL,
  `participant_id` int(11) DEFAULT NULL,
  `communication` int(11) DEFAULT NULL CHECK (`communication` between 1 and 5),
  `confidence` int(11) DEFAULT NULL CHECK (`confidence` between 1 and 5),
  `logic` int(11) DEFAULT NULL CHECK (`logic` between 1 and 5),
  `engagement` int(11) DEFAULT NULL CHECK (`engagement` between 1 and 5),
  `comments` text DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`feedback_id`, `session_id`, `participant_id`, `communication`, `confidence`, `logic`, `engagement`, `comments`, `submitted_at`) VALUES
(1, 1, 9, 5, 4, 4, 5, 'Great session with clear points.', '2025-04-12 18:14:32'),
(2, 2, 11, 4, 4, 5, 4, 'Very informative.', '2025-04-12 18:14:32'),
(3, 3, 15, 3, 4, 4, 4, 'Helpful tips shared.', '2025-04-12 18:14:32'),
(4, 4, 17, 4, 5, 5, 5, 'Loved the examples.', '2025-04-12 18:14:32'),
(5, 5, 13, 5, 3, 4, 5, 'Could include more visuals.', '2025-04-12 18:14:32'),
(6, 6, 9, 4, 5, 4, 3, 'Good pace and clarity.', '2025-04-12 18:14:32'),
(7, 7, 14, 5, 5, 5, 5, 'One of the best sessions!', '2025-04-12 18:14:32'),
(8, 8, 8, 3, 3, 4, 4, 'Quite engaging.', '2025-04-12 18:14:32'),
(9, 9, 9, 4, 4, 5, 5, 'Speaker was very confident.', '2025-04-12 18:14:32'),
(10, 10, 15, 5, 5, 5, 5, 'Perfectly structured.', '2025-04-12 18:14:32');

-- --------------------------------------------------------

--
-- Table structure for table `moderatordetails`
--

CREATE TABLE `moderatordetails` (
  `moderator_details_id` int(11) NOT NULL,
  `moderator_id` int(11) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `expertise_field` varchar(100) DEFAULT NULL,
  `experience_years` int(11) DEFAULT NULL,
  `profile_picture_url` text DEFAULT NULL,
  `linked_url` text DEFAULT NULL,
  `status` enum('pending','approved') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `moderatordetails`
--

INSERT INTO `moderatordetails` (`moderator_details_id`, `moderator_id`, `designation`, `expertise_field`, `experience_years`, `profile_picture_url`, `linked_url`, `status`) VALUES
(1, 3, 'Senior Project Manager', 'Project Management', 6, 'static\\uploads\\3_aagamj2004gmailcom.jpeg', 'https://www.linkedin.com/in/aagam-jain-8b65a7282/', 'approved'),
(2, 7, 'Software Engineer', 'IT', 4, 'static/uploads/7_netrajigneshpatelgmailcom.jpeg', 'https://www.linkedin.com/in/netra-patel-5338322a9/', 'approved'),
(3, 10, 'Product Owner', 'Product', 3, 'static/uploads/10_kellyadamsexamplecom.jpeg', 'https://example.com/kelly', 'pending'),
(4, 12, 'Data Analyst', 'Analytics', 4, 'static/uploads/12_jessicariceexamplecom.jpeg', 'https://example.com/jessica', 'approved'),
(5, 16, 'DevOps Engineer', 'DevOps', 5, 'static/uploads/16_debraperkinsexamplecom.jpeg', 'https://example.com/debra', 'pending'),
(6, 10, 'Tech Lead', 'Software', 6, 'static/uploads/10_kellyadams2examplecom.jpeg', 'https://example.com/kelly2', 'approved'),
(7, 12, 'System Architect', 'Architecture', 8, 'static/uploads/12_jessicarice2examplecom.jpeg', 'https://example.com/jessica2', 'pending'),
(8, 16, 'ML Engineer', 'AI', 4, 'static/uploads/16_debraperkins2examplecom.jpeg', 'https://example.com/debra2', 'approved'),
(9, 10, 'UI/UX Designer', 'Design', 3, 'static/uploads/10_kellyadams3examplecom.jpeg', 'https://example.com/kelly3', 'approved'),
(10, 12, 'Cloud Specialist', 'Cloud', 2, 'static/uploads/12_jessicarice3examplecom.jpeg', 'https://example.com/jessica3', 'pending'),
(11, 16, 'Security Analyst', 'Cybersecurity', 5, 'static/uploads/16_debraperkins3examplecom.jpeg', 'https://example.com/debra3', 'approved'),
(12, 10, 'QA Manager', 'Testing', 6, 'static/uploads/10_kellyadams4examplecom.jpeg', 'https://example.com/kelly4', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `role` enum('Participant','Moderator','Evaluator') DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `user_id`, `role`, `email`, `message`, `is_read`, `created_at`) VALUES
(2, 3, 'Moderator', 'aagamj2004@gmail.com', 'Your moderator profile has been approved!', 0, '2025-04-12 16:53:24'),
(3, 9, 'Participant', 'chrisrios@example.com', 'You’ve joined a new session.', 0, '2025-04-12 18:16:27'),
(4, 10, 'Moderator', 'juliewilson@example.com', 'Your session was approved.', 0, '2025-04-12 18:16:27'),
(5, 8, 'Participant', 'aaroncole@example.com', 'Feedback submitted.', 0, '2025-04-12 18:16:27'),
(6, 12, 'Moderator', 'jessicarice@example.com', 'Session invite sent.', 0, '2025-04-12 18:16:27'),
(7, 13, 'Participant', 'raymondhughes@example.com', 'Reminder: upcoming session.', 0, '2025-04-12 18:16:27'),
(8, 14, 'Evaluator', 'angelashaw@example.com', 'Moderator approval pending.', 0, '2025-04-12 18:16:27'),
(9, 15, 'Participant', 'carlpatterson@example.com', 'Session feedback needed.', 0, '2025-04-12 18:16:27'),
(10, 16, 'Moderator', 'debraperkins@example.com', 'Profile update request.', 0, '2025-04-12 18:16:27'),
(11, 17, 'Participant', 'philiparmstrong@example.com', 'Session recording available.', 0, '2025-04-12 18:16:27'),
(12, 7, 'Moderator', 'netrajigneshpatel@gmail.com', 'Your moderator profile has been approved!', 0, '2025-04-13 08:38:18');

-- --------------------------------------------------------

--
-- Table structure for table `sessionparticipants`
--

CREATE TABLE `sessionparticipants` (
  `session_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_present` tinyint(1) DEFAULT 1,
  `joined_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessionparticipants`
--

INSERT INTO `sessionparticipants` (`session_id`, `user_id`, `is_present`, `joined_at`) VALUES
(1, 9, 1, '2024-06-01 10:02:00'),
(2, 11, 1, '2024-07-10 14:01:00'),
(3, 15, 1, '2024-08-05 09:05:00'),
(4, 17, 1, '2024-09-12 13:10:00'),
(5, 13, 1, '2024-10-20 15:05:00'),
(6, 9, 1, '2024-11-01 11:01:00'),
(7, 14, 1, '2024-11-15 10:03:00'),
(8, 8, 1, '2024-12-01 14:00:00'),
(9, 9, 1, '2025-01-10 13:05:00'),
(10, 15, 1, '2025-02-20 09:03:00');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `session_id` int(11) NOT NULL,
  `topic` varchar(255) DEFAULT NULL,
  `moderator_id` int(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `session_picture_url` text NOT NULL,
  `status` enum('pending','active','completed') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `topic`, `moderator_id`, `start_time`, `end_time`, `session_picture_url`, `status`) VALUES
(1, 'Building Scalable Systems', 10, '2024-06-01 10:00:00', '2024-06-01 11:00:00', 'static/sessions/session1.jpg', 'completed'),
(2, 'Intro to Cybersecurity', 12, '2024-07-10 14:00:00', '2024-07-10 15:00:00', 'static/sessions/session2.jpg', 'active'),
(3, 'Effective Product Thinking', 16, '2024-08-05 09:00:00', '2024-08-05 10:30:00', 'static/sessions/session3.jpg', 'pending'),
(4, 'UI Trends in 2025', 10, '2024-09-12 13:00:00', '2024-09-12 14:00:00', 'static/sessions/session4.jpg', 'completed'),
(5, 'Cloud Computing Basics', 12, '2024-10-20 15:00:00', '2024-10-20 16:30:00', 'static/sessions/session5.jpg', 'pending'),
(6, 'DevOps Pipelines', 16, '2024-11-01 11:00:00', '2024-11-01 12:30:00', 'static/sessions/session6.jpg', 'active'),
(7, 'Data Visualization 101', 10, '2024-11-15 10:00:00', '2024-11-15 11:00:00', 'static/sessions/session7.jpg', 'pending'),
(8, 'Microservices Architecture', 12, '2024-12-01 14:00:00', '2024-12-01 15:00:00', 'static/sessions/session8.jpg', 'completed'),
(9, 'Soft Skills for Engineers', 16, '2025-01-10 13:00:00', '2025-01-10 14:00:00', 'static/sessions/session9.jpg', 'active'),
(10, 'Intro to Machine Learning', 10, '2025-02-20 09:00:00', '2025-02-20 10:30:00', 'static/sessions/session10.jpg', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Participant','Moderator','Evaluator') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `role`) VALUES
(1, 'Gautam Chauhan', 'gautam@gmail.com', '12345678a', 'Evaluator'),
(2, 'Ruchita Mahale', 'ruchi04ta@gmail.com', '12345678a', 'Participant'),
(3, 'Aagam Jain', 'aagamj2004@gmail.com', '12345678a', 'Moderator'),
(7, 'Netra Patel', 'netrajigneshpatel@gmail.com', '12345678a', 'Moderator'),
(8, 'yansi Jain', 'yansij2005@gmail.com', 'yansijain02', 'Participant'),
(9, 'Christopher Rios', 'chrisrios@example.com', 'password9', 'Participant'),
(10, 'Julie Wilson', 'juliewilson@example.com', 'password10', 'Moderator'),
(11, 'Aaron Cole', 'aaroncole@example.com', 'password11', 'Participant'),
(12, 'Jessica Rice', 'jessicarice@example.com', 'password12', 'Moderator'),
(13, 'Raymond Hughes', 'raymondhughes@example.com', 'password13', 'Participant'),
(14, 'Angela Shaw', 'angelashaw@example.com', 'password14', 'Evaluator'),
(15, 'Carl Patterson', 'carlpatterson@example.com', 'password15', 'Participant'),
(16, 'Debra Perkins', 'debraperkins@example.com', 'password16', 'Moderator'),
(17, 'Philip Armstrong', 'philiparmstrong@example.com', 'password17', 'Participant'),
(18, 'Riya Mahale', 'rucita@gmail.com', 'riya@123', 'Participant');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chatmessages`
--
ALTER TABLE `chatmessages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `session_id` (`session_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `session_id` (`session_id`),
  ADD KEY `participant_id` (`participant_id`);

--
-- Indexes for table `moderatordetails`
--
ALTER TABLE `moderatordetails`
  ADD PRIMARY KEY (`moderator_details_id`),
  ADD KEY `moderator_id` (`moderator_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `sessionparticipants`
--
ALTER TABLE `sessionparticipants`
  ADD PRIMARY KEY (`session_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `moderator_id` (`moderator_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chatmessages`
--
ALTER TABLE `chatmessages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `moderatordetails`
--
ALTER TABLE `moderatordetails`
  MODIFY `moderator_details_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chatmessages`
--
ALTER TABLE `chatmessages`
  ADD CONSTRAINT `chatmessages_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`session_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chatmessages_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`session_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`participant_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `moderatordetails`
--
ALTER TABLE `moderatordetails`
  ADD CONSTRAINT `moderatordetails_ibfk_1` FOREIGN KEY (`moderator_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `sessionparticipants`
--
ALTER TABLE `sessionparticipants`
  ADD CONSTRAINT `sessionparticipants_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`session_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sessionparticipants_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`moderator_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

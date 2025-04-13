from flask import Flask, render_template, request, redirect, url_for, flash, session
import re,os
import mysql.connector
from werkzeug.utils import secure_filename
from flask_mail import Mail, Message


app = Flask(__name__)
app.secret_key = os.urandom(24)


# app.config['MAIL_SERVER'] = 'smtp.gmail.com'
# app.config['MAIL_PORT'] = 587
# app.config['MAIL_USE_TLS'] = True
# app.config['MAIL_USERNAME'] = 'www.gautam.2005@gmail.com'
# app.config['MAIL_PASSWORD'] = 'gautam.2005.54637281'  # Use App Password if 2FA is on
# app.config['MAIL_DEFAULT_SENDER'] = 'www.gautam.2005@gmail.com'

# mail = Mail(app)



db = mysql.connector.connect(
    host="localhost",
    port="3307",
    user="root",
    password="",
    database="speakspace"
)
cursor = db.cursor(dictionary=True)

@app.route('/')
def home():
    return render_template('home.html')



@app.route("/login", methods=["GET", "POST"])
def login():
    errors = {}
    form_data = {}

    if request.method == "POST":
        email = request.form["email"].strip().lower()
        password = request.form["password"]
        form_data["email"] = email

        # Email validation
        if not re.match(EMAIL_REGEX, email):
            errors["email"] = "Invalid email address."

        # Password empty check
        if not password:
            errors["password"] = "Password is required."

        if not errors:
            # try:
                cursor.execute("SELECT user_id, username, password, role FROM Users WHERE email = %s", (email,))
                user = cursor.fetchone()

                if user and (password == user["password"]):
                    session["user_id"] = user["user_id"]
                    session["username"] = user["username"]
                    session["role"] = user["role"]

                    if user["role"] == "Participant":
                        return redirect(url_for("participant_dashboard"))
                    elif user["role"] == "Moderator":
                        return redirect(url_for("moderator_dashboard"))
                    elif user["role"] == "Evaluator":
                        return redirect(url_for("evaluator_dashboard"))
                else:
                    errors["password"] = "Invalid email or password."

            # except mysql.connector.Error:
            #     errors["email"] = "Database error. Try again later."

        return render_template("login.html", errors=errors, form_data=form_data)

    return render_template("login.html", errors={}, form_data={})




# Regex patterns
EMAIL_REGEX = r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$'
PASSWORD_REGEX = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@#$%^&+=]{8,}$'
NAME_REGEX = r'^[A-Za-z\s]{2,100}$'

@app.route("/register", methods=["GET", "POST"])
def register():
    errors = {}
    form_data = {}

    if request.method == "POST":
        name = request.form['name'].strip()
        email = request.form['email'].strip().lower()
        role = request.form['role'].capitalize()
        password = request.form['password']
        confirm_password = request.form['confirm_password']

        form_data = {
            "name": name,
            "email": email,
            "role": role,
        }

        # Validation
        if not re.match(NAME_REGEX, name):
            errors['name'] = "Name must contain only letters and spaces (2-100 characters)."

        if not re.match(EMAIL_REGEX, email):
            errors['email'] = "Invalid email address."

        if not re.match(PASSWORD_REGEX, password):
            errors['password'] = "Password must be 8+ chars and include letters and numbers."

        if password != confirm_password:
            errors['confirm_password'] = "Passwords do not match."

        if not role in ["Participant", "Moderator", "Evaluator"]:
            errors['role'] = "Please select a valid role."

        if errors:
            return render_template("registration.html", errors=errors, form_data=form_data)

        try:

            cursor.execute("""
                INSERT INTO Users (username, email, password, role)
                VALUES (%s, %s, %s, %s)
            """, (name, email, password, role))
            db.commit()

            cursor.execute("SELECT user_id FROM Users WHERE email=%s", (email,))
            user = cursor.fetchone()

            session['user_id'] = user["user_id"]
            session['username'] = name
            session['role'] = role

            if role == 'Participant':
                return redirect(url_for('participant_dashboard'))
            elif role == 'Moderator':
                return redirect(url_for('moderator_dashboard'))
            elif role == 'Evaluator':
                return redirect(url_for('evaluator_dashboard'))

        except mysql.connector.Error as err:
            errors['email'] = "Email already exists or database error."
            return render_template("registration.html", errors=errors, form_data=form_data)

    return render_template("registration.html", errors=errors, form_data=form_data)

@app.route("/participant/dashboard")
def participant_dashboard():
    user_id = session.get("user_id")

    # All sessions
    cursor.execute("SELECT * FROM sessions")
    sessions = cursor.fetchall()

    # Active sessions
    cursor.execute("SELECT * FROM sessions WHERE status='active'")
    active_sessions = cursor.fetchall()

    # Participant performance data
    cursor.execute("""
        SELECT 
            COUNT(*) AS total_sessions,
            SUM(is_present) AS attended_sessions 
        FROM sessionparticipants 
        WHERE user_id = %s
    """, (user_id,))
    stats = cursor.fetchone()
    total = stats['total_sessions'] or 0
    attended = stats['attended_sessions'] or 0

    return render_template(
        "participant_dashboard.html",
        sessions=sessions,
        active_sessions=active_sessions,
        total_sessions=total,
        attended_sessions=attended
    )



@app.route("/moderator_dashboard")
def moderator_dashboard():
    if "user_id" not in session or session.get("role") != "Moderator":
        return redirect(url_for("login"))

    user_id = session["user_id"]

    cursor.execute("""
        SELECT designation, expertise_field, experience_years, linked_url,status, profile_picture_url
        FROM moderatordetails 
        WHERE moderator_id = %s
    """, (user_id,))
    moderator_data = cursor.fetchone()

    show_popup = True
    image_filename = None
    
    hey=moderator_data["status"]
    
    print(moderator_data["profile_picture_url"])
    if moderator_data:
        designation, expertise, experience, linked_url, status, profile_picture_url = moderator_data
        show_popup = any(field is None or field == "" for field in [designation, expertise, experience, linked_url,status])
        if profile_picture_url:
            import os
            image_filename = os.path.basename(profile_picture_url)
   

    return render_template(
        "moderator_dashboard.html",
        show_popup=show_popup,
        image_filename=moderator_data["profile_picture_url"],
        status=hey
    )



UPLOAD_FOLDER = 'static/uploads'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Ensure folder exists
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

# ✅ Place this helper function here
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


UPLOAD_FOLDER = 'static/uploads'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Ensure folder exists (absolute path)
os.makedirs(os.path.join(app.root_path, UPLOAD_FOLDER), exist_ok=True)

# ✅ Helper function to check allowed image types
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route("/save_moderator_info", methods=["POST"])
def save_moderator_info():
    if "user_id" not in session or session.get("role") != "Moderator":
        return redirect(url_for("login"))

    moderator_id = session["user_id"]
    designation = request.form["designation"]
    expertise = request.form["expertise"]
    experience = request.form["experience"]
    linkedin = request.form["linkedin"]

    # Get moderator's email from Users table
    cursor.execute("SELECT email FROM Users WHERE user_id = %s", (moderator_id,))
    result = cursor.fetchone()
    email = result["email"] if result else "unknown"

    # Clean email to use in filename (remove @ and .)
    clean_email = re.sub(r'[^a-zA-Z0-9]', '', email)

    # Handle image upload
    file = request.files.get("profile_picture")
    profile_picture_url = None  # Will store 'static/uploads/filename.ext'

    if file and allowed_file(file.filename):
        ext = file.filename.rsplit('.', 1)[1].lower()
        unique_filename = f"{moderator_id}_{clean_email}.{ext}"
        relative_path = os.path.join(app.config['UPLOAD_FOLDER'], unique_filename)
        absolute_path = os.path.join(app.root_path, relative_path)

        file.save(absolute_path)
        profile_picture_url = relative_path.replace("\\", "/")

    # Check if moderator record exists
    cursor.execute("SELECT * FROM moderatordetails WHERE moderator_id = %s", (moderator_id,))
    existing = cursor.fetchone()

    if existing:
        cursor.execute("""
            UPDATE moderatordetails
            SET designation = %s,
                expertise_field = %s,
                experience_years = %s,
                linked_url = %s,
                profile_picture_url = %s,
                status = 'pending'
            WHERE moderator_id = %s
        """, (designation, expertise, experience, linkedin, profile_picture_url, moderator_id))
    else:
        cursor.execute("""
            INSERT INTO moderatordetails (
                moderator_id, designation, expertise_field, experience_years,
                linked_url, profile_picture_url, status
            ) VALUES (%s, %s, %s, %s, %s, %s, 'pending')
        """, (moderator_id, designation, expertise, experience, linkedin, profile_picture_url))

    db.commit()
    return redirect(url_for("moderator_dashboard"))


@app.route("/evaluator/dashboard")
def evaluator_dashboard():
    cursor.execute("SELECT * FROM moderatordetails WHERE status = 'pending'")
    pending_moderators = cursor.fetchall()
    pending_count = len(pending_moderators)

    return render_template("evaluator_dashboard.html", moderators=pending_moderators, pending_count=pending_count)


@app.route("/handle_moderator_request", methods=["POST"])
def handle_moderator_request():
    moderator_id = request.form['moderator_id']
    action = request.form['action']

    cursor.execute("SELECT email FROM users WHERE user_id = %s", (moderator_id,))
    result = cursor.fetchone()
    moderator_email = result["email"] if result else None

    if action == 'approve':
        cursor.execute("UPDATE moderatordetails SET status = 'approved' WHERE moderator_id = %s", (moderator_id,))
        message = "Your moderator profile has been approved!"
    else:
        cursor.execute("DELETE FROM moderatordetails WHERE moderator_id = %s", (moderator_id,))
        message = "Your moderator request has been declined."

    # Store notification (optional)
    cursor.execute("""
        INSERT INTO notifications (user_id, role, email, message)
        VALUES (%s, 'Moderator', %s, %s)
    """, (moderator_id, moderator_email, message))

    # Send email using Flask-Mail
    # if moderator_email:
    #     msg = Message("Moderator Request Status - SpeakSpace", recipients=[moderator_email])
    #     msg.body = message
    #     mail.send(msg)

    db.commit()
    return redirect(url_for('evaluator_dashboard'))


@app.route('/participant/notifications')
def participant_notifications():
    user_id = session.get('user_id')
    if not user_id:
        return "User not logged in", 403
    print("Inside")
    cursor.execute("""
        SELECT message, created_at, is_read 
        FROM notifications 
        WHERE user_id = %s 
        ORDER BY created_at DESC
    """, (user_id,))

    notifications = cursor.fetchall()
    cursor.close()

    return render_template('notifications.html', notifications=notifications)



    
if __name__ == '__main__':
    app.run(debug=True)


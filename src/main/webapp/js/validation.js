document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('studentForm');

    if (form) {
        const emailPattern = /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
        const phonePattern = /^[0-9]{10}$/;
        const fullName = document.getElementById('fullName');
        const rollNumber = document.getElementById('rollNumber');
        const grade = document.getElementById('grade');
        const email = document.getElementById('email');
        const phone = document.getElementById('phone');
        function validateFullName() {
            const value = fullName.value.trim();
            const errorElement = document.getElementById('fullNameError');

            if (value === '') {
                showError(fullName, errorElement, 'Full name is required');
                return false;
            } else if (value.length < 3) {
                showError(fullName, errorElement, 'Full name must be at least 3 characters');
                return false;
            } else {
                showSuccess(fullName, errorElement);
                return true;
            }
        }

        function validateRollNumber() {
            const value = rollNumber.value.trim();
            const errorElement = document.getElementById('rollNumberError');

            if (value === '') {
                showError(rollNumber, errorElement, 'Roll number is required');
                return false;
            } else {
                showSuccess(rollNumber, errorElement);
                return true;
            }
        }

        function validateGrade() {
            const value = grade.value.trim();
            const errorElement = document.getElementById('gradeError');

            if (value === '') {
                showError(grade, errorElement, 'Grade is required');
                return false;
            } else {
                showSuccess(grade, errorElement);
                return true;
            }
        }

        function validateEmail() {
            const value = email.value.trim();
            const errorElement = document.getElementById('emailError');

            if (value === '') {
                showError(email, errorElement, 'Email is required');
                return false;
            } else if (!emailPattern.test(value)) {
                showError(email, errorElement, 'Please enter a valid email address');
                return false;
            } else {
                showSuccess(email, errorElement);
                return true;
            }
        }

        function validatePhone() {
            const value = phone.value.trim();
            const errorElement = document.getElementById('phoneError');

            if (value === '') {
                showError(phone, errorElement, 'Phone number is required');
                return false;
            } else if (!phonePattern.test(value)) {
                showError(phone, errorElement, 'Phone number must be exactly 10 digits');
                return false;
            } else {
                showSuccess(phone, errorElement);
                return true;
            }
        }

        function showError(inputElement, errorElement, message) {
            inputElement.classList.add('error');
            inputElement.classList.remove('success');
            errorElement.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + message;
            errorElement.classList.add('error-message');
            errorElement.classList.remove('success-message');
        }

        function showSuccess(inputElement, errorElement) {
            inputElement.classList.remove('error');
            inputElement.classList.add('success');
            errorElement.innerHTML = '<i class="fas fa-check-circle"></i> Looks good!';
            errorElement.classList.remove('error-message');
            errorElement.classList.add('success-message');
        }

        function clearError(inputElement, errorElement) {
            inputElement.classList.remove('error');
            inputElement.classList.remove('success');
            errorElement.textContent = '';
            errorElement.classList.remove('error-message');
            errorElement.classList.remove('success-message');
        }

        fullName.addEventListener('blur', validateFullName);
        fullName.addEventListener('input', function () {
            if (fullName.value.trim().length > 0) {
                validateFullName();
            }
        });

        rollNumber.addEventListener('blur', validateRollNumber);
        rollNumber.addEventListener('input', function () {
            if (rollNumber.value.trim().length > 0) {
                validateRollNumber();
            }
        });

        grade.addEventListener('blur', validateGrade);
        grade.addEventListener('input', function () {
            if (grade.value.trim().length > 0) {
                validateGrade();
            }
        });

        email.addEventListener('blur', validateEmail);
        email.addEventListener('input', function () {
            if (email.value.trim().length > 0) {
                validateEmail();
            }
        });

        phone.addEventListener('blur', validatePhone);

        phone.addEventListener('input', function () {
            this.value = this.value.replace(/[^0-9]/g, '');
            if (this.value.length > 0) {
                validatePhone();
            }
        });

        form.addEventListener('submit', function (e) {
            const isFullNameValid = validateFullName();
            const isRollNumberValid = validateRollNumber();
            const isGradeValid = validateGrade();
            const isEmailValid = validateEmail();
            const isPhoneValid = validatePhone();

            if (!isFullNameValid || !isRollNumberValid || !isGradeValid || !isEmailValid || !isPhoneValid) {
                e.preventDefault();
                const firstError = form.querySelector('.error');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    firstError.focus();
                }

                alert('Please fix the errors in the form before submitting.');
            }
        });

        const formInputs = form.querySelectorAll('input[type="text"], input[type="email"], input[type="tel"], input[type="date"]');
        formInputs.forEach(input => {
            input.addEventListener('focus', function () {
                this.style.transform = 'translateY(-2px)';
            });

            input.addEventListener('blur', function () {
                this.style.transform = 'translateY(0)';
            });
        });
    }
});

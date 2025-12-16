document.addEventListener('DOMContentLoaded', function () {
    fetch('api/students')
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to fetch student data');
            }
            return response.json();
        })
        .then(data => {
            console.log('API Response:', data);

            const students = data.students || [];
            const totalStudents = data.total || students.length;

            console.log('Total students from API:', totalStudents);
            console.log('Student data:', students);

            updateStatistics(students, totalStudents);
            createCharts(students);
        })
        .catch(error => {
            console.error('Error fetching student data:', error);
            updateStatistics([], 0);
        });
});


function updateStatistics(students, totalStudents) {
    const total = totalStudents || students.length;
    const totalElement = document.getElementById('totalStudents');
    animateCounter(totalElement, total);

    const newStudents = Math.ceil(total * 0.3);
    const newElement = document.getElementById('newStudents');
    animateCounter(newElement, newStudents);

    const grades = [...new Set(students.map(s => s.grade).filter(Boolean))];
    const gradesElement = document.getElementById('totalGrades');
    animateCounter(gradesElement, grades.length);
    const avgAge = calculateAverageAge(students);
    const ageElement = document.getElementById('averageAge');
    if (ageElement) {
        setTimeout(() => {
            ageElement.textContent = avgAge.toFixed(1);
        }, 300);
    }
}

function animateCounter(element, targetValue) {
    if (!element) return;

    let current = 0;
    const increment = targetValue / 30;
    const timer = setInterval(() => {
        current += increment;
        if (current >= targetValue) {
            element.textContent = targetValue;
            clearInterval(timer);
        } else {
            element.textContent = Math.floor(current);
        }
    }, 50);
}

function calculateAverageAge(students) {
    if (students.length === 0) return 0;

    const gradeAgeMap = {
        '1': 6, '2': 7, '3': 8, '4': 9, '5': 10,
        '6': 11, '7': 12, '8': 13, '9': 14, '10': 15,
        '11': 16, '12': 17
    };

    let totalAge = 0;
    students.forEach(student => {
        const grade = student.grade;
        totalAge += gradeAgeMap[grade] || 15;
    });

    return totalAge / students.length;
}

function createCharts(students) {
    createGradeDistributionChart(students);
    createGenderDistributionChart(students);
    createAgeDistributionChart(students);
}

function createGradeDistributionChart(students) {
    const gradeCount = {};

    students.forEach(student => {
        const grade = student.grade || 'Unknown';
        gradeCount[grade] = (gradeCount[grade] || 0) + 1;
    });

    const labels = Object.keys(gradeCount).sort((a, b) => {
        const numA = parseInt(a);
        const numB = parseInt(b);
        if (isNaN(numA)) return 1;
        if (isNaN(numB)) return -1;
        return numA - numB;
    });

    const data = labels.map(label => gradeCount[label]);

    const ctx = document.getElementById('gradeChart');
    if (!ctx) return;

    const isDark = document.body.classList.contains('dark-mode');
    const textColor = isDark ? '#F9FAFB' : '#111827';

    new Chart(ctx, {
        type: 'pie',
        data: {
            labels: labels.map(l => `Grade ${l}`),
            datasets: [{
                label: 'Students',
                data: data,
                backgroundColor: [
                    '#6366f1', // Primary blue
                    '#10b981', // Green
                    '#f59e0b', // Orange
                    '#8b5cf6', // Purple
                    '#ec4899', // Pink
                    '#06b6d4', // Cyan
                    '#F43F5E', // Rose
                    '#84cc16'  // Lime
                ],
                borderColor: isDark ? '#1F2937' : '#FFFFFF',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        color: textColor,
                        padding: 15,
                        font: {
                            size: 12,
                            family: 'Inter'
                        }
                    }
                },
                title: {
                    display: false
                }
            }
        }
    });
}

function createGenderDistributionChart(students) {
    let maleCount = 0;
    let femaleCount = 0;
    let otherCount = 0;

    students.forEach(student => {
        const gender = student.gender;

        if (gender === 'Male') {
            maleCount++;
        } else if (gender === 'Female') {
            femaleCount++;
        } else if (gender === 'Other') {
            otherCount++;
        }
    });

    console.log('Gender counts:', { maleCount, femaleCount, otherCount, total: students.length });

    const ctx = document.getElementById('genderChart');
    if (!ctx) return;

    const isDark = document.body.classList.contains('dark-mode');
    const textColor = isDark ? '#F9FAFB' : '#111827';

    const labels = [];
    const data = [];
    const colors = [];

    if (maleCount > 0) {
        labels.push('Male');
        data.push(maleCount);
        colors.push('#6366f1');
    }
    if (femaleCount > 0) {
        labels.push('Female');
        data.push(femaleCount);
        colors.push('#ec4899');
    }
    if (otherCount > 0) {
        labels.push('Other');
        data.push(otherCount);
        colors.push('#8b5cf6');
    }

    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [{
                label: 'Students',
                data: data,
                backgroundColor: colors,
                borderColor: isDark ? '#1F2937' : '#FFFFFF',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        color: textColor,
                        padding: 15,
                        font: {
                            size: 12,
                            family: 'Inter'
                        }
                    }
                },
                title: {
                    display: false
                }
            }
        }
    });
}

function createAgeDistributionChart(students) {
    const ageCount = {};

    const gradeAgeMap = {
        '1': 6, '2': 7, '3': 8, '4': 9, '5': 10,
        '6': 11, '7': 12, '8': 13, '9': 14, '10': 15,
        '11': 16, '12': 17
    };

    students.forEach(student => {
        const age = gradeAgeMap[student.grade] || 15;
        ageCount[age] = (ageCount[age] || 0) + 1;
    });

    const ages = Object.keys(ageCount).sort((a, b) => a - b);
    const counts = ages.map(age => ageCount[age]);

    const ctx = document.getElementById('ageChart');
    if (!ctx) return;

    const isDark = document.body.classList.contains('dark-mode');
    const textColor = isDark ? '#F9FAFB' : '#111827';
    const gridColor = isDark ? '#374151' : '#E5E7EB';

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ages.map(age => `${age} years`),
            datasets: [{
                label: 'Number of Students',
                data: counts,
                backgroundColor: '#6366f1',
                borderColor: '#4f46e5',
                borderWidth: 1,
                borderRadius: 8
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 1,
                        color: textColor,
                        font: {
                            family: 'Inter'
                        }
                    },
                    grid: {
                        color: gridColor
                    }
                },
                x: {
                    ticks: {
                        color: textColor,
                        font: {
                            family: 'Inter'
                        }
                    },
                    grid: {
                        display: false
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                },
                title: {
                    display: false
                }
            }
        }
    });
}

document.addEventListener('click', function (e) {
    if (e.target.closest('#theme-toggle')) {
        setTimeout(() => {
            location.reload();
        }, 600);
    }
});

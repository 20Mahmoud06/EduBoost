// lib/data/teachers_data.dart
import 'package:learny/data/teacher_profile_data.dart';
import 'package:learny/data/video_content_data.dart';
import 'package:learny/data/task_data.dart';
import 'package:learny/data/live_session_data.dart';
import 'package:learny/data/live_session_status.dart';

final List<TeacherProfileData> teachersData = [
  TeacherProfileData(
    id: 'nader_abdullah',
    name: 'Nader Abdullah',
    imageAsset: 'assets/teachers/Nader Abdullah.jpg', // Replace with actual asset
    grade: '1st Secondary',
    subject: 'English',
    curriculum: 'Egyptian curriculum',
    videos: [
      VideoContentData(
        id: 'nader_english_video1',
        title: 'Unit 2 Vocab & Reading',
        videoThumbnailAsset: 'assets/video_thumbnails/english_unit2.png', // Replace
        description: 'Detailed walkthrough of Unit 2 vocabulary and reading passages. Focus on comprehension and usage.',
        homework: 'Complete exercises on p. 31 to p. 36. Prepare a short summary of the main reading passage.',
        date: '21 May 2025',
        videoUrl: 'https://example.com/nader_video1',
      ),
      VideoContentData(
        id: 'nader_english_video2',
        title: 'Advanced Grammar: Conditionals',
        videoThumbnailAsset: 'assets/video_thumbnails/english_grammar_conditionals.png', // Replace
        description: 'In-depth explanation of all conditional types (0, 1, 2, 3, mixed) with examples and common mistakes.',
        homework: 'Worksheet on conditional sentences (provided separately). Write 5 example sentences for each type.',
        date: '28 May 2025',
        videoUrl: 'https://example.com/nader_video2',
      ),
    ],
    tasks: [
      TaskData(
        id: 'nader_task_1',
        title: 'Unit 2 Grammar Homework',
        description: 'Complete exercises on page 57-59 covering past tenses and reported speech. Ensure all answers are written in full sentences.',
        assignedDate: '18 May 2025',
        dueDate: '25 May 2025',
        isCompleted: true,
      ),
      TaskData(
        id: 'nader_task_2',
        title: 'Essay: My Favorite Book',
        description: 'Write a 300-word essay about your favorite book. Focus on plot, characters, and why you recommend it. Check for grammar and spelling.',
        assignedDate: '26 May 2025',
        dueDate: '02 Jun 2025',
      ),
    ],
    liveSessions: [
      LiveSessionData(
        id: 'nader_live_1',
        title: 'Live Q&A: Unit 2 & Grammar',
        description: 'Open session to discuss any questions from Unit 2 (Vocab, Reading, Grammar) and the recent grammar topics.',
        homework: 'Prepare your questions in advance. Review notes on conditionals.',
        date: '30 May 2025',
        time: '7:00 PM - 8:00 PM',
        status: LiveSessionStatus.upcoming,
        meetingLink: 'https://zoom.us/j/naderenglishlive1',
      ),
      LiveSessionData(
        id: 'nader_live_2',
        title: 'Interactive Story Writing',
        description: 'Collaborative story writing session. We will build a story together, focusing on creative expression and narrative structure.',
        homework: 'Think of a character and a setting for a short story.',
        date: '06 Jun 2025',
        time: '6:30 PM - 7:30 PM',
        status: LiveSessionStatus.upcoming,
      ),
    ],
  ),
  TeacherProfileData(
    id: 'osama_mabrouk',
    name: 'Osama Mabrouk',
    imageAsset: 'assets/teachers/Osama Mabrouk.jpg', // Replace
    grade: '3rd Secondary',
    subject: 'Chemistry',
    curriculum: 'Egyptian curriculum',
    videos: [
      VideoContentData(
        id: 'osama_chem_video1',
        title: 'Organic Chemistry: Alkanes',
        videoThumbnailAsset: 'assets/video_thumbnails/chem_alkanes.png', // Replace
        description: 'Nomenclature, properties, and reactions of alkanes. Includes isomerism.',
        homework: 'Chapter 10 problems (1-15). Draw all isomers of hexane.',
        date: '15 Jun 2025',
      ),
      VideoContentData(
        id: 'osama_chem_video2',
        title: 'Titration Techniques & Calculations',
        videoThumbnailAsset: 'assets/video_thumbnails/chem_titration.png', // Replace
        description: 'Step-by-step guide to performing acid-base titrations and calculating concentrations.',
        homework: 'Solve titration problems worksheet.',
        date: '22 Jun 2025',
      ),
    ],
    tasks: [
      TaskData(
        id: 'osama_task_1',
        title: 'Lab Report: Acid-Base Titration',
        description: 'Submit the full lab report for the titration experiment conducted in class. Include all sections: introduction, materials, method, results, discussion, conclusion.',
        assignedDate: '10 Jun 2025',
        dueDate: '17 Jun 2025',
      ),
      TaskData(
        id: 'osama_task_2',
        title: 'Problem Set: Stoichiometry',
        description: 'Solve problems 1-20 from Chapter 3 on stoichiometry, limiting reagents, and percent yield.',
        assignedDate: '18 Jun 2025',
        dueDate: '25 Jun 2025',
        isCompleted: false,
      ),
    ],
    liveSessions: [
      LiveSessionData(
        id: 'osama_live_1',
        title: 'Solving Complex Chemical Equations',
        description: 'Interactive session on balancing challenging chemical equations and understanding reaction mechanisms.',
        homework: 'Review chapters on reaction types. Bring 2-3 difficult equations to discuss.',
        date: '28 Jun 2025',
        time: '8:00 PM - 9:30 PM',
        status: LiveSessionStatus.upcoming,
        meetingLink: 'https://meet.google.com/osamachemLive',
      ),
    ],
  ),
  TeacherProfileData(
    id: 'eslam_hamdy',
    name: 'Eslam Hamdy',
    imageAsset: 'assets/teachers/Eslam Hamdy.jpg', // Replace
    grade: '1st Secondary',
    subject: 'Geography',
    curriculum: 'Egyptian curriculum',
    videos: [
      VideoContentData(
        id: 'eslam_geo_video1',
        title: 'Introduction to Maps',
        videoThumbnailAsset: 'assets/video_thumbnails/geo_maps.png', // Replace
        description: 'Types of maps, map scales, and how to read map symbols.',
        homework: 'Find 3 different types of maps online and describe their purpose.',
        date: '01 Jul 2025',
      ),
    ],
    tasks: [
      TaskData(
        id: 'eslam_task_1',
        title: 'Map Reading Exercise',
        description: 'Complete the map reading worksheet using the provided topographic map.',
        assignedDate: '02 Jul 2025',
        dueDate: '09 Jul 2025',
      ),
    ],
    liveSessions: [], // No live sessions yet
  ),
  TeacherProfileData(
    id: 'nahla_ashraf',
    name: 'Nahla Ashraf',
    imageAsset: 'assets/teachers/Nahla Ashraf.jpg', // Replace
    grade: '3rd Secondary',
    subject: 'Physics',
    curriculum: 'Egyptian curriculum',
    videos: [
      VideoContentData(
        id: 'nahla_phy_video1',
        title: 'Newton\'s Laws of Motion',
        videoThumbnailAsset: 'assets/video_thumbnails/phy_newton.png', // Replace
        description: 'Detailed explanation of Newton\'s three laws with real-world examples.',
        homework: 'Solve problems 1-10 from Chapter 4.',
        date: '10 Jul 2025',
      ),
    ],
    tasks: [
      TaskData(
        id: 'nahla_task_1',
        title: 'Physics Problem Set 1',
        description: 'Problems on kinematics and dynamics.',
        assignedDate: '11 Jul 2025',
        dueDate: '18 Jul 2025',
      ),
    ],
    liveSessions: [
      LiveSessionData(
        id: 'nahla_live_1',
        title: 'Modern Physics Q&A',
        description: 'Discussion and problem-solving session on topics in modern physics.',
        homework: 'Review notes on relativity and quantum mechanics.',
        date: '20 Jul 2025',
        time: '6:00 PM - 7:00 PM',
        status: LiveSessionStatus.upcoming,
      ),
    ],
  ),
  TeacherProfileData(
    id: 'estefano_cortez',
    name: 'Estefano Cortez',
    imageAsset: 'assets/teachers/Estefano Cortez .jpg', // Replace
    grade: '2nd Preparatory',
    subject: 'Science',
    curriculum: 'Spanish curriculum',
    videos: [
      VideoContentData(
        id: 'estefano_science_video1',
        title: 'El Ciclo del Agua (The Water Cycle)',
        videoThumbnailAsset: 'assets/video_thumbnails/science_water_cycle_es.png', // Replace
        description: 'Explicación del ciclo del agua: evaporación, condensación, precipitación y recolección.',
        homework: 'Dibuja el ciclo del agua y escribe una breve descripción de cada etapa.',
        date: '05 Aug 2025',
      ),
      VideoContentData(
        id: 'estefano_science_video2',
        title: 'Los Ecosistemas (Ecosystems)',
        videoThumbnailAsset: 'assets/video_thumbnails/science_ecosystems_es.png', // Replace
        description: 'Qué son los ecosistemas, tipos de ecosistemas y la importancia de su conservación.',
        homework: 'Investiga un ecosistema local y describe sus componentes bióticos y abióticos.',
        date: '12 Aug 2025',
      ),
    ],
    tasks: [
      TaskData(
        id: 'estefano_task_1',
        title: 'Cuestionario: El Cuerpo Humano',
        description: 'Responde las preguntas sobre los principales sistemas del cuerpo humano.',
        assignedDate: '07 Aug 2025',
        dueDate: '14 Aug 2025',
      ),
    ],
    liveSessions: [
      LiveSessionData(
        id: 'estefano_live_1',
        title: 'Preguntas y Respuestas: Ciencias',
        description: 'Sesión en vivo para resolver dudas sobre los temas vistos en clase.',
        homework: 'Prepara tus preguntas sobre el ciclo del agua y los ecosistemas.',
        date: '19 Aug 2025',
        time: '5:00 PM - 6:00 PM (Hora de España)',
        status: LiveSessionStatus.upcoming,
      ),
    ],
  ),
  TeacherProfileData(
    id: 'steve_jones',
    name: 'Steve Jones',
    imageAsset: 'assets/teachers/Steve Jones.jpg', // Replace
    grade: '1st Secondary',
    subject: 'Mathematics',
    curriculum: 'English curriculum',
    videos: [], tasks: [], liveSessions: [], // Kept empty as per request
  ),
  TeacherProfileData(
    id: 'fahd_algaafary',
    name: 'Fahd Algaafary',
    imageAsset: 'assets/teachers/Fahd Algaafary.jpg', // Replace
    grade: '3rd Primary',
    subject: 'English',
    curriculum: 'Saudi curriculum',
    videos: [], tasks: [], liveSessions: [], // Kept empty as per request
  ),
  TeacherProfileData(
    id: 'ahmed_yaseen',
    name: 'Ahmed Yaseen',
    imageAsset: 'assets/teachers/Ahmad Yaseen.jpg', // Replace
    grade: '3rd Secondary',
    subject: 'Physics',
    curriculum: 'Egyptian curriculum',
    videos: [
      VideoContentData(
        id: 'ahmed_physics_video1',
        title: 'مراجعة قوانين كيرشوف (Kirchhoff\'s Laws Review)',
        videoThumbnailAsset: 'assets/video_thumbnails/phy_kirchhoff_ar.png', // Replace
        description: 'شرح تفصيلي لقوانين كيرشوف للتيار والجهد مع أمثلة تطبيقية.',
        homework: 'حل مسائل الفصل الثالث (دوائر التيار المستمر).',
        date: '10 Sep 2025',
      ),
      VideoContentData(
        id: 'ahmad_physics_video2',
        title: 'المجال المغناطيسي للتيار الكهربي (Magnetic Field of Electric Current)',
        videoThumbnailAsset: 'assets/video_thumbnails/phy_magnetic_field_ar.png', // Replace
        description: 'استنتاج قانون المجال المغناطيسي لسلك مستقيم وملف دائري وملف لولبي.',
        homework: 'حل مسائل الفصل الرابع (التأثير المغناطيسي للتيار الكهربي).',
        date: '17 Sep 2025',
      ),
    ],
    tasks: [
      TaskData(
        id: 'ahmad_task_1',
        title: 'واجب الفيزياء: دوائر التيار المتردد',
        description: 'حل مجموعة مسائل متنوعة على دوائر التيار المتردد (RLC).',
        assignedDate: '12 Sep 2025',
        dueDate: '19 Sep 2025',
      ),
    ],
    liveSessions: [
      LiveSessionData(
        id: 'ahmad_live_1',
        title: 'جلسة نقاشية: الفيزياء الحديثة',
        description: 'مناقشة مفتوحة حول مفاهيم الفيزياء الحديثة وأسئلة الطلاب.',
        homework: 'مراجعة فصل ازدواجية الموجة والجسيم.',
        date: '24 Sep 2025',
        time: '7:00 PM - 8:30 PM (توقيت القاهرة)',
        status: LiveSessionStatus.upcoming,
      ),
    ],
  ),
  TeacherProfileData(
    id: 'gorge_danlopp',
    name: 'Gorge Danlopp',
    imageAsset: 'assets/teachers/Gorge Danlopp.jpg', // Replace
    grade: '5th Primary',
    subject: 'Science',
    curriculum: 'German curriculum',
    videos: [
      VideoContentData(
        id: 'gorge_science_video1',
        title: 'Pflanzen und Fotosynthese (Plants and Photosynthesis)',
        videoThumbnailAsset: 'assets/video_thumbnails/science_photosynthesis_de.png', // Replace
        description: 'Wie Pflanzen ihre eigene Nahrung herstellen. Erklärung der Fotosynthese.',
        homework: 'Zeichne eine Pflanze und beschrifte die Teile, die für die Fotosynthese wichtig sind.',
        date: '03 Oct 2025',
      ),
    ],
    tasks: [
      TaskData(
        id: 'gorge_task_1',
        title: 'Experiment: Keimung von Bohnen',
        description: 'Beobachte und dokumentiere die Keimung von Bohnensamen über eine Woche.',
        assignedDate: '05 Oct 2025',
        dueDate: '12 Oct 2025',
      ),
    ],
    liveSessions: [
      LiveSessionData(
        id: 'gorge_live_1',
        title: 'Fragestunde: Unser Sonnensystem',
        description: 'Live-Sitzung, um Fragen über Planeten, Sterne und unser Sonnensystem zu beantworten.',
        homework: 'Überlege dir drei Fragen zum Weltall.',
        date: '17 Oct 2025',
        time: '4:00 PM - 5:00 PM (MEZ)',
        status: LiveSessionStatus.upcoming,
      ),
    ],
  ),
  TeacherProfileData(
    id: 'amr_hanafy',
    name: 'Amr Hanafy',
    imageAsset: 'assets/teachers/Amr Hanafy.jpg', // Replace
    grade: '1st Secondary',
    subject: 'Mathematics',
    curriculum: 'Egyptian curriculum',
    videos: [
      VideoContentData(
        id: 'amr_math_video1',
        title: 'مقدمة في حساب المثلثات (Introduction to Trigonometry)',
        videoThumbnailAsset: 'assets/video_thumbnails/math_trigonometry_ar.png', // Replace
        description: 'شرح النسب المثلثية الأساسية للزوايا الحادة وتطبيقاتها.',
        homework: 'حل تمارين الكتاب المدرسي صفحة ٧٥.',
        date: '01 Nov 2025',
      ),
      VideoContentData(
        id: 'amr_math_video2',
        title: 'حل المعادلات الأسية (Solving Exponential Equations)',
        videoThumbnailAsset: 'assets/video_thumbnails/math_exponential_eq_ar.png', // Replace
        description: 'طرق حل المعادلات الأسية المختلفة باستخدام قوانين الأسس واللوغاريتمات.',
        homework: 'حل ورقة العمل المرفقة.',
        date: '08 Nov 2025',
      ),
    ],
    tasks: [
      TaskData(
        id: 'amr_task_1',
        title: 'واجب الرياضيات: المتتابعات والمتسلسلات',
        description: 'حل مسائل متنوعة على المتتابعات الحسابية والهندسية.',
        assignedDate: '10 Nov 2025',
        dueDate: '17 Nov 2025',
      ),
    ],
    liveSessions: [
      LiveSessionData(
        id: 'amr_live_1',
        title: 'مراجعة ليلة الامتحان: الجبر',
        description: 'مراجعة شاملة لأهم موضوعات الجبر وحل نماذج امتحانات.',
        homework: 'تجميع الأسئلة الصعبة من المنهج.',
        date: '22 Nov 2025',
        time: '8:00 PM - 10:00 PM (توقيت القاهرة)',
        status: LiveSessionStatus.upcoming,
      ),
    ],
  ),
];

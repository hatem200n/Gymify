import 'package:gymfiy/core/model/exercise_model.dart';
import 'package:gymfiy/core/model/explore_item.dart';

class ExploerData {
  static List<ExploreItem> bodyParts = const [
    ExploreItem(
      name: 'lower arms',
      image: 'assets/images/bodyParts/low-armas.png',
      description: 'The lower arms include the forearm, wrist and hand.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'shoulders',
      image: 'assets/images/bodyParts/shoulders.png',
      description:
          'The shoulders include the scapula, glenohumeral joint and surrounding muscles.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'cardio',
      image: 'assets/images/bodyParts/cardio.png',
      description:
          'The cardio refers to the heart and surrounding blood vessels.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'upper arms',
      image: 'assets/images/bodyParts/upper-arms.png',
      description:
          'The upper arms include the humerus, scapula, and surrounding muscles.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'chest',
      image: 'assets/images/bodyParts/chest.png',
      description:
          'The chest refers to the thoracic cavity and surrounding muscles.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'lower legs',
      image: 'assets/images/bodyParts/lower-legs.png',
      description:
          'The lower legs include the femur, patella, tibia, fibula, ankle and foot.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'back',
      image: 'assets/images/bodyParts/back.png',
      description:
          'The back refers to the thoracic and lumbar regions of the spine and surrounding muscles.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'upper legs',
      image: 'assets/images/bodyParts/lower-legs.png',
      description:
          'The upper legs include the femur, patella, tibia, fibula, ankle and foot.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'waist',
      image: 'assets/images/bodyParts/waist.png',
      description:
          'The waist refers to the abdominal region and surrounding muscles.',
      duration: '30-60 seconds',
    ),
  ];

  static List<ExploreItem> muscles = const [
    ExploreItem(
      name: 'hands',
      image: 'assets/images/bodyParts/upper-arms.png',
      description: 'The hands include the fingers, wrist and forearm.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'soleus',
      image: 'assets/images/bodyParts/shoulders.png',
      description:
          'The soleus is a muscle located in the lower leg, responsible for plantarflexion of the foot.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'inner thighs',
      image: 'assets/images/bodyParts/waist.png',
      description:
          'The inner thighs refer to the adductor muscles of the thigh, responsible for bringing the legs together.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'lower abs',
      image: 'assets/images/bodyParts/low-armas.png',
      description:
          'The lower abs refer to the abdominal muscles located in the lower region of the abdomen.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'abdominals',
      image: 'assets/images/bodyParts/back.png',
      description:
          'The abdominals refer to the muscles of the abdominal wall, responsible for supporting the spine and surrounding organs.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'deltoids',
      image: 'assets/images/bodyParts/lower-legs.png',
      description:
          'The deltoids are a group of muscles located in the shoulder, responsible for abduction, flexion, and rotation of the arm.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'chest',
      image: 'assets/images/bodyParts/chest.png',
      description:
          'The chest refers to the muscles of the thoracic cavity and surrounding regions, responsible for supporting the spine and surrounding organs.',
      duration: '30-60 seconds',
    ),
  ];

  static List<ExploreItem> equipments = const [
    ExploreItem(
      name: 'dumbbell',
      image: 'assets/images/equipments/dumbbell.png',
      description:
          'A dumbbell is a free weight used for strength training exercises, typically involving the arms, shoulders and legs.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'barbell',
      image: 'assets/images/equipments/barbell.png',
      description:
          'A barbell is a long bar with weights attached to either end, used for strength training exercises, typically involving the arms, shoulders and legs.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'kettlebell',
      image: 'assets/images/equipments/kettlebell.png',
      description:
          'A kettlebell is a cast iron weight with a handle, used for strength training exercises, typically involving the arms, shoulders and legs.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'resistance band',
      image: 'assets/images/equipments/resistance-band.png',
      description:
          'A resistance band is a flexible band used for strength training exercises, typically involving the arms, shoulders and legs.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'smith machine',
      image: 'assets/images/equipments/smith-machine.png',
      description:
          'A smith machine is a multi-functional piece of equipment used for strength training exercises, typically involving the arms, shoulders and legs.',
      duration: '30-60 seconds',
    ),
    ExploreItem(
      name: 'stationary bike',
      image: 'assets/images/equipments/stationary-bike.png',
      description:
          'A stationary bike is a type of exercise bike used for cardiovascular exercises, typically involving the legs.',
      duration: '30-60 seconds',
    ),
  ];

  static List<ExerciseModel> dummyExercises = [
    const ExerciseModel(
      id: 'VPPtusI',
      name: 'Inverted Row Bent Knees',
      gifUrl: 'https://static.exercisedb.dev/media/VPPtusI.gif',
      targetMuscles: ['upper back'],
      bodyParts: ['back'],
      equipments: ['body weight'],
      secondaryMuscles: ['biceps', 'forearms'],
      instructions: [
        'Set up a bar at waist height and lie underneath it.',
        'Grab the bar with an overhand grip.',
        'Position your body straight with heels on the ground.',
        'Pull your chest toward the bar.',
        'Lower slowly and repeat.',
      ],
    ),
    const ExerciseModel(
      id: '8d8qJQI',
      name: 'Barbell Reverse Grip Incline Bench Row',
      gifUrl: 'https://static.exercisedb.dev/media/8d8qJQI.gif',
      targetMuscles: ['upper back'],
      bodyParts: ['back'],
      equipments: ['barbell'],
      secondaryMuscles: ['biceps', 'forearms'],
      instructions: [
        'Set incline bench at 45 degrees.',
        'Sit facing the backrest.',
        'Grab barbell with reverse grip.',
        'Pull bar toward upper abdomen.',
        'Lower slowly and repeat.',
      ],
    ),
    const ExerciseModel(
      id: 'JGKowMS',
      name: 'Smith Narrow Row',
      gifUrl: 'https://static.exercisedb.dev/media/JGKowMS.gif',
      targetMuscles: ['upper back'],
      bodyParts: ['back'],
      equipments: ['smith machine'],
      secondaryMuscles: ['biceps', 'rear deltoids'],
      instructions: [
        'Adjust seat height.',
        'Grip handles narrowly.',
        'Pull handles toward body.',
        'Squeeze shoulder blades.',
        'Return slowly.',
      ],
    ),
    const ExerciseModel(
      id: 'dmgMp3n',
      name: 'Barbell Incline Row',
      gifUrl: 'https://static.exercisedb.dev/media/dmgMp3n.gif',
      targetMuscles: ['upper back'],
      bodyParts: ['back'],
      equipments: ['barbell'],
      secondaryMuscles: ['biceps', 'forearms'],
      instructions: [
        'Lie face down on incline bench.',
        'Grip barbell overhand.',
        'Pull bar to chest.',
        'Lower slowly.',
        'Repeat.',
      ],
    ),
    const ExerciseModel(
      id: 'ZqNOWQ6',
      name: 'Lever Reverse Grip Vertical Row',
      gifUrl: 'https://static.exercisedb.dev/media/ZqNOWQ6.gif',
      targetMuscles: ['upper back'],
      bodyParts: ['back'],
      equipments: ['leverage machine'],
      secondaryMuscles: ['biceps', 'forearms'],
      instructions: [
        'Adjust seat and footplate.',
        'Grip handles underhand.',
        'Pull handles to chest.',
        'Release slowly.',
        'Repeat.',
      ],
    ),
    const ExerciseModel(
      id: 'w2oRpuH',
      name: 'Lever Alternating Narrow Grip Seated Row',
      gifUrl: 'https://static.exercisedb.dev/media/w2oRpuH.gif',
      targetMuscles: ['upper back'],
      bodyParts: ['back'],
      equipments: ['leverage machine'],
      secondaryMuscles: ['biceps', 'forearms'],
      instructions: [
        'Sit with straight back.',
        'Pull one handle at a time.',
        'Squeeze shoulder blades.',
        'Alternate sides.',
      ],
    ),
    const ExerciseModel(
      id: 'zYmNaoY',
      name: 'Elevator',
      gifUrl: 'https://static.exercisedb.dev/media/zYmNaoY.gif',
      targetMuscles: ['upper back'],
      bodyParts: ['back'],
      equipments: ['body weight'],
      secondaryMuscles: ['shoulders', 'trapezius'],
      instructions: [
        'Stand with feet shoulder-width apart.',
        'Bend forward at waist.',
        'Lower upper body.',
        'Raise back up.',
        'Repeat.',
      ],
    ),
  ];
}

# Malicious-system-call-detection
Analysis of system call sequences for anomaly detection

The Malicious System Call execution Detection (MSCD) module creates a program-based ISCS (Immediate system call sequence) profile at Client virtual manager and system-wide-based ISCS profile at Cloud manager and consistently monitors them in a periodic manner centrally from the cloud manager to detect any deviation or intrusion. Any deviation in the profile is then used to detect an intrusion, after which configured response mech- anisms are taken in practice by the cloud manager. The novelty of the approach lies in the ISCS algorithm for the structuring of system calls generated during a program execution for anomaly detection and the use of both program and system-level-based detection strategies, which increases the reliability. The algorithm reduces the amount of computational needs for intrusion detection in the cloud, and multiple detection strategies at low cost reduce the threat of intrusion detection system failures when individual IDS get exploited at CVMs. Being centrally controlled and managed at the CM, the ISCS algorithm provides a high level of trust, easy configuration, immediate notification, and response-generation capabilities.


  

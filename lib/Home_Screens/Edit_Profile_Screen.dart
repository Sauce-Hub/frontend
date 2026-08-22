import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {

  final String name;
  final String username;

  const EditProfileScreen({
    super.key,
    required this.name,
    required this.username,
  });

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  late TextEditingController nameController;

  late TextEditingController usernameController;

  final TextEditingController emailController =
  TextEditingController(
    text: 'basmala@example.com',
  );

  final TextEditingController newPasswordController =
  TextEditingController();

  final TextEditingController currentPasswordController =
  TextEditingController();

  bool showNewPassword = false;
  bool showCurrentPassword = false;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.name);

    usernameController =
        TextEditingController(text: widget.username);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
      const Color(0xFFFFFAF8),

      appBar: AppBar(
        backgroundColor:
        const Color(0xFFFFFAF8),

        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF302A28),
          ),
        ),

        title: const Text(
          'Edit Profile',

          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF24201F),
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(
            horizontal: 30,
          ),

          child: Column(
            children: [


              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      const SizedBox(height: 15),


                      Container(
                        width: 108,
                        height: 108,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFFFE4D7),
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.12),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 55,
                          color: Color(0xFFFF7043),
                        ),
                      ),

                      const SizedBox(height: 15),


                      const Align(
                        alignment:
                        Alignment.centerLeft,

                        child: Text(
                          'Email',

                          style: TextStyle(
                            color:
                            Color(0xFF674F47),

                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller:
                        emailController,

                        decoration:
                        InputDecoration(
                          filled: true,

                          fillColor:
                          Colors.white,

                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                                8),

                            borderSide:
                            const BorderSide(
                              color:
                              Color(0xFFE2DCD9),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),


                      const Align(
                        alignment:
                        Alignment.centerLeft,

                        child: Text(
                          'Username',

                          style: TextStyle(
                            color:
                            Color(0xFF674F47),

                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller:
                        usernameController,

                        decoration:
                        InputDecoration(
                          filled: true,

                          fillColor:
                          Colors.white,

                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                                8),

                            borderSide:
                            const BorderSide(
                              color:
                              Color(0xFFE2DCD9),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),



                      const Align(
                        alignment:
                        Alignment.centerLeft,

                        child: Text(
                          'New Password',

                          style: TextStyle(
                            color:
                            Color(0xFF674F47),

                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller:
                        newPasswordController,

                        obscureText:
                        !showNewPassword,

                        decoration:
                        InputDecoration(
                          hintText:
                          'Enter new password',

                          filled: true,

                          fillColor:
                          Colors.white,

                          suffixIcon:
                          IconButton(
                            onPressed: () {
                              setState(() {
                                showNewPassword =
                                !showNewPassword;
                              });
                            },

                            icon: Icon(
                              showNewPassword
                                  ? Icons.visibility
                                  : Icons
                                  .visibility_off_outlined,

                              color:
                              const Color(
                                  0xFF674F47),
                            ),
                          ),

                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                                8),

                            borderSide:
                            const BorderSide(
                              color:
                              Color(0xFFE2DCD9),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      const Align(
                        alignment:
                        Alignment.centerLeft,

                        child: Text(
                          'Current Password',

                          style: TextStyle(
                            color:
                            Color(0xFF674F47),

                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller:
                        currentPasswordController,

                        obscureText:
                        !showCurrentPassword,

                        decoration:
                        InputDecoration(
                          hintText:
                          'Enter your current password',

                          filled: true,

                          fillColor:
                          Colors.white,

                          suffixIcon:
                          IconButton(
                            onPressed: () {
                              setState(() {
                                showCurrentPassword =
                                !showCurrentPassword;
                              });
                            },

                            icon: Icon(
                              showCurrentPassword
                                  ? Icons.visibility
                                  : Icons
                                  .visibility_off_outlined,

                              color:
                              const Color(
                                  0xFF674F47),
                            ),
                          ),

                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                                8),

                            borderSide:
                            const BorderSide(
                              color:
                              Color(0xFFE2DCD9),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Align(
                        alignment:
                        Alignment.centerLeft,

                        child: Text(
                          'Enter your current password to confirm changes.',

                          style: TextStyle(
                            fontSize: 12,
                            color:
                            Color(0xFF513F39),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),


              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {

                    Navigator.pop(
                      context,

                      {
                        'name':
                        nameController.text,

                        'username':
                        usernameController.text,

                      },
                    );
                  },

                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(0xFFFF6238),

                    padding:
                    const EdgeInsets.symmetric(
                      vertical: 16,
                    ),

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          30),
                    ),
                  ),

                  child: const Text(
                    'Save Changes',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight:
                      FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
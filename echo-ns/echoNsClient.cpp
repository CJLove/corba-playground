// eg3_clt.cc - This is the source code of example 3 used in Chapter 2
//              "The Basics" of the omniORB user guide.
//
//              This is the client. It uses the COSS naming service
//              to obtain the object reference.
//
// Usage: eg3_clt
//
//
//        On startup, the client lookup the object reference from the
//        COS naming service.
//
//        The name which the object is bound to is as follows:
//              root  [context]
//               |
//              text  [context] kind [my_context]
//               |
//              Echo  [object]  kind [Object]
//

#include "echo.h"

#ifdef HAVE_STD
#include <iostream>
using namespace std;
#else
#include <iostream.h>
#endif
#include <unistd.h>

static CORBA::Object_ptr getObjectReference(CORBA::ORB_ptr orb);

static void hello(Echo_ptr e) {
  if (CORBA::is_nil(e)) {
    cerr << "hello: The object reference is nil!\n" << endl;
    return;
  }

  static uint32_t count = 0;

  std::string helloMsg = "Hello " + std::to_string(count++);

  CORBA::String_var src = (const char*) helloMsg.c_str();
  CORBA::String_var dest = e->echoString(src);

  cerr << "I said, \"" << (char *)src << "\"." << endl
       << "The Echo object replied, \"" << (char *)dest << "\"." << endl;
}

//////////////////////////////////////////////////////////////////////

int main(int argc, char **argv) {
  try {
    CORBA::ORB_var orb = CORBA::ORB_init(argc, argv);

    CORBA::Object_var obj = getObjectReference(orb);

    Echo_var echoref = Echo::_narrow(obj);

    while (true) {
      hello(echoref);

      sleep(2);
    }

    orb->destroy();
  } catch (CORBA::TRANSIENT &) {
    cerr << "Caught system exception TRANSIENT -- unable to contact the "
         << "server." << endl;
  } catch (CORBA::SystemException &ex) {
    cerr << "Caught a CORBA::" << ex._name()  << endl;
  } catch (CORBA::Exception &ex) {
    cerr << "Caught CORBA::Exception: " << ex._name() << endl;
  }
  return 0;
}

//////////////////////////////////////////////////////////////////////

static CORBA::Object_ptr getObjectReference(CORBA::ORB_ptr orb) {
  CosNaming::NamingContext_var rootContext;

  try {
    // Obtain a reference to the root context of the Name service:
    CORBA::Object_var obj;
    obj = orb->resolve_initial_references("NameService");

    // Narrow the reference returned.
    rootContext = CosNaming::NamingContext::_narrow(obj);

    if (CORBA::is_nil(rootContext)) {
      cerr << "Failed to narrow the root naming context." << endl;
      return CORBA::Object::_nil();
    }
  } catch (CORBA::NO_RESOURCES &) {
    cerr << "Caught NO_RESOURCES exception. You must configure omniORB "
         << "with the location" << endl
         << "of the naming service." << endl;
    return CORBA::Object::_nil();
  } catch (CORBA::ORB::InvalidName &ex) {
    // This should not happen!
    cerr << "Service required is invalid [does not exist]." << endl;
    return CORBA::Object::_nil();
  }

  // Create a name object, containing the name test/context:
  CosNaming::Name name;
  name.length(2);

  name[0].id = (const char *)"test";         // string copied
  name[0].kind = (const char *)"my_context"; // string copied
  name[1].id = (const char *)"Echo";
  name[1].kind = (const char *)"Object";
  // Note on kind: The kind field is used to indicate the type
  // of the object. This is to avoid conventions such as that used
  // by files (name.type -- e.g. test.ps = postscript etc.)

  try {
    // Resolve the name to an object reference.
    auto obj = rootContext->resolve(name);
    CORBA::String_var sior(orb->object_to_string(obj));
    std::cout << "Reference " << sior << "\n";
    return rootContext->resolve(name);
  } catch (CosNaming::NamingContext::NotFound &ex) {
    // This exception is thrown if any of the components of the
    // path [contexts or the object] aren't found:
    cerr << "Context not found." << endl;
  } catch (CORBA::TRANSIENT &ex) {
    cerr << "Caught system exception TRANSIENT -- unable to contact the "
         << "naming service." << endl
         << "Make sure the naming server is running and that omniORB is "
         << "configured correctly." << endl;
  } catch (CORBA::SystemException &ex) {
    cerr << "Caught a CORBA::" << ex._name()
         << " while using the naming service." << endl;
  }
  return CORBA::Object::_nil();
}

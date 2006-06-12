// Swig module description file for a C dynamic library source file
// Generate with: swig -c++ -python -o py_wrap.cpp pyniflib.i

/* Copyright (c) 2006, NIF File Format Library and Tools
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

   * Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.

   * Redistributions in binary form must reproduce the above
     copyright notice, this list of conditions and the following
     disclaimer in the documentation and/or other materials provided
     with the distribution.

   * Neither the name of the NIF File Format Library and Tools
     project nor the names of its contributors may be used to endorse
     or promote products derived from this software without specific
     prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE. */

%module niflib
%include "stl.i"
%include "std_map.i"
%include "exception.i"
%include "std_list.i"
%include "typemaps.i"

// enable string assignment in structure member functions
%typemap(in) std::string* ($*1_ltype tempstr) {
	char * temps; int templ;
 	if (PyString_AsStringAndSize($input, &temps, &templ)) return NULL;
 	tempstr = $*1_ltype(temps, templ);
 	$1 = &tempstr;
}
%typemap(out) std::string* "$result = PyString_FromStringAndSize($1->data(), $1->length());";

// we need a version of SWIG that has SWIG_CATCH_STDEXCEPT support
#if SWIG_VERSION >= 0x010322
%exception {
	try {
		$action
	}
	SWIG_CATCH_STDEXCEPT // catch std::exception
	catch (...) {
		SWIG_exception(SWIG_UnknownError, "Unknown exception");
	}
}
#endif

// we need to define this because the wrapper gets confused about NIFLIB_API'd functions otherwise
#define NIFLIB_API
#define NIFLIB_HIDDEN

%include "gen/obj_defines.h"

%{
    #include "niflib.h"
%}

// we need the definition of the template classes before we define the template Python names below
template <class T> 
struct Key {
	float time;
	T data, forward_tangent, backward_tangent;
	float tension, bias, continuity;
};

%ignore Key;
%template(vector_byte) std::vector<byte>;
%template(vector_ushort) std::vector<ushort>;
%template(vector_SkinShape) std::vector<SkinShape>;
%template(vector_string) std::vector<std::string>;
%template(vector_Triangle) std::vector<Triangle>;
%template(vector_Vector3) std::vector<Vector3>;
%template(vector_float) std::vector<float>;
%template(vector_SkinWeight) std::vector<SkinWeight>;
%template(vector_NodeGroup) std::vector<NodeGroup>;
%template(vector_Color4) std::vector<Color4>;
%template(vector_Float4) std::vector<Float4>;
%template(vector_uint) std::vector<uint>;
%template(vector_FurniturePosition) std::vector<FurniturePosition>;
%template(vector_hkTriangle) std::vector<hkTriangle>;
%template(vector_SkinShapeGroup) std::vector<SkinShapeGroup>;
%template(vector_ControllerLink) std::vector<ControllerLink>;
%template(vector_AVObject) std::vector<AVObject>;
%template(vector_Morph) std::vector<Morph>;
%template(vector_LODRange) std::vector<LODRange>;
%template(vector_Quaternion) std::vector<Quaternion>;
%template(vector_Particle) std::vector<Particle>;
%template(vector_MipMap) std::vector<MipMap>;
%template(vector_SkinData) std::vector<SkinData>;
%template(vector_SkinPartition) std::vector<SkinPartition>;
%template(vector_ShaderTexDesc) std::vector<ShaderTexDesc>;
%template(vector_MatchGroup) std::vector<MatchGroup>;
%template(pair_int_float) std::pair<int, float>;
%template(map_int_float) std::map<int, float>;

%include "niflib.h"
%include "obj/NiObject.h"
%include "obj/AKeyedData.h"
%include "obj/AParticleModifier.h"
%include "obj/bhkRefObject.h"
%include "obj/bhkSerializable.h"
%include "obj/AbhkConstraint.h"
%include "obj/AbhkRagdollConstraint.h"
%include "obj/bhkShape.h"
%include "obj/AbhkShapeCollection.h"
%include "obj/bhkSphereRepShape.h"
%include "obj/bhkConvexShape.h"
%include "obj/bhkWorldObject.h"
%include "obj/bhkEntity.h"
%include "obj/NiCollisionObject.h"
%include "obj/NiExtraData.h"
%include "obj/NiInterpolator.h"
%include "obj/NiBlendInterpolator.h"
%include "obj/NiBSplineInterpolator.h"
%include "obj/NiObjectNET.h"
%include "obj/NiAVObject.h"
%include "obj/NiDynamicEffect.h"
%include "obj/NiLight.h"
%include "obj/NiProperty.h"
%include "obj/NiPSysModifier.h"
%include "obj/NiPSysEmitter.h"
%include "obj/NiPSysVolumeEmitter.h"
%include "obj/NiTimeController.h"
%include "obj/ABoneLODController.h"
%include "obj/NiSingleInterpolatorController.h"
%include "obj/APSysCtlr.h"
%include "obj/NiTriBasedGeom.h"
%include "obj/NiTriBasedGeomData.h"
%include "obj/APSysData.h"
%include "obj/bhkBlendCollisionObject.h"
%include "obj/bhkBlendController.h"
%include "obj/bhkBoxShape.h"
%include "obj/bhkCapsuleShape.h"
%include "obj/bhkCollisionObject.h"
%include "obj/bhkConvexVerticesShape.h"
%include "obj/bhkHingeConstraint.h"
%include "obj/bhkLimitedHingeConstraint.h"
%include "obj/bhkListShape.h"
%include "obj/bhkMalleableConstraint.h"
%include "obj/bhkMoppBvTreeShape.h"
%include "obj/bhkMultiSphereShape.h"
%include "obj/bhkNiTriStripsShape.h"
%include "obj/bhkPackedNiTriStripsShape.h"
%include "obj/bhkPrismaticConstraint.h"
%include "obj/bhkRagdollConstraint.h"
%include "obj/bhkRigidBody.h"
%include "obj/bhkRigidBodyT.h"
%include "obj/bhkSimpleShapePhantom.h"
%include "obj/bhkSPCollisionObject.h"
%include "obj/bhkSphereShape.h"
%include "obj/bhkStiffSpringConstraint.h"
%include "obj/bhkTransformShape.h"
%include "obj/bhkConvexTransformShape.h"
%include "obj/BSBound.h"
%include "obj/BSFurnitureMarker.h"
%include "obj/BSParentVelocityModifier.h"
%include "obj/BSPSysArrayEmitter.h"
%include "obj/BSXFlags.h"
%include "obj/hkPackedNiTriStripsData.h"
%include "obj/NiAlphaController.h"
%include "obj/NiAlphaProperty.h"
%include "obj/NiAmbientLight.h"
%include "obj/NiAutoNormalParticlesData.h"
%include "obj/NiBinaryExtraData.h"
%include "obj/NiBlendBoolInterpolator.h"
%include "obj/NiBlendFloatInterpolator.h"
%include "obj/NiBlendPoint3Interpolator.h"
%include "obj/NiBlendTransformInterpolator.h"
%include "obj/NiBoneLODController.h"
%include "obj/NiBoolData.h"
%include "obj/NiBooleanExtraData.h"
%include "obj/NiBoolInterpolator.h"
%include "obj/NiBoolTimelineInterpolator.h"
%include "obj/NiBSBoneLODController.h"
%include "obj/NiBSplineBasisData.h"
%include "obj/NiBSplineCompFloatInterpolator.h"
%include "obj/NiBSplineCompPoint3Interpolator.h"
%include "obj/NiBSplineCompTransformInterpolator.h"
%include "obj/NiBSplineData.h"
%include "obj/NiCamera.h"
%include "obj/NiCollisionData.h"
%include "obj/NiColorData.h"
%include "obj/NiColorExtraData.h"
%include "obj/NiControllerManager.h"
%include "obj/NiControllerSequence.h"
%include "obj/NiDefaultAVObjectPalette.h"
%include "obj/NiDirectionalLight.h"
%include "obj/NiDitherProperty.h"
%include "obj/NiFlipController.h"
%include "obj/NiFloatData.h"
%include "obj/NiFloatExtraData.h"
%include "obj/NiFloatExtraDataController.h"
%include "obj/NiFloatInterpolator.h"
%include "obj/NiFloatsExtraData.h"
%include "obj/NiFogProperty.h"
%include "obj/NiGeomMorpherController.h"
%include "obj/NiGravity.h"
%include "obj/NiIntegerExtraData.h"
%include "obj/NiIntegersExtraData.h"
%include "obj/NiKeyframeController.h"
%include "obj/BSKeyframeController.h"
%include "obj/NiKeyframeData.h"
%include "obj/NiLightColorController.h"
%include "obj/NiLightDimmerController.h"
%include "obj/NiLookAtController.h"
%include "obj/NiLookAtInterpolator.h"
%include "obj/NiMaterialColorController.h"
%include "obj/NiMaterialProperty.h"
%include "obj/NiMeshPSysData.h"
%include "obj/NiMorphData.h"
%include "obj/NiMultiTargetTransformController.h"
%include "obj/NiNode.h"
%include "obj/AvoidNode.h"
%include "obj/FxWidget.h"
%include "obj/FxButton.h"
%include "obj/FxRadioButton.h"
%include "obj/NiBillboardNode.h"
%include "obj/NiBSAnimationNode.h"
%include "obj/NiBSParticleNode.h"
%include "obj/NiLODNode.h"
%include "obj/NiPalette.h"
%include "obj/NiParticleBomb.h"
%include "obj/NiParticleColorModifier.h"
%include "obj/NiParticleGrowFade.h"
%include "obj/NiParticleMeshModifier.h"
%include "obj/NiParticleRotation.h"
%include "obj/NiParticles.h"
%include "obj/NiAutoNormalParticles.h"
%include "obj/NiParticleMeshes.h"
%include "obj/NiParticlesData.h"
%include "obj/NiParticleMeshesData.h"
%include "obj/NiParticleSystem.h"
%include "obj/NiMeshParticleSystem.h"
%include "obj/NiParticleSystemController.h"
%include "obj/NiBSPArrayController.h"
%include "obj/NiPathController.h"
%include "obj/NiPathInterpolator.h"
%include "obj/NiPixelData.h"
%include "obj/NiPlanarCollider.h"
%include "obj/NiPoint3Interpolator.h"
%include "obj/NiPointLight.h"
%include "obj/NiPosData.h"
%include "obj/NiPSysAgeDeathModifier.h"
%include "obj/NiPSysBombModifier.h"
%include "obj/NiPSysBoundUpdateModifier.h"
%include "obj/NiPSysBoxEmitter.h"
%include "obj/NiPSysColliderManager.h"
%include "obj/NiPSysColorModifier.h"
%include "obj/NiPSysCylinderEmitter.h"
%include "obj/NiPSysData.h"
%include "obj/NiPSysDragModifier.h"
%include "obj/NiPSysEmitterCtlr.h"
%include "obj/NiPSysEmitterCtlrData.h"
%include "obj/NiPSysEmitterDeclinationCtlr.h"
%include "obj/NiPSysEmitterDeclinationVarCtlr.h"
%include "obj/NiPSysEmitterInitialRadiusCtlr.h"
%include "obj/NiPSysEmitterLifeSpanCtlr.h"
%include "obj/NiPSysEmitterSpeedCtlr.h"
%include "obj/NiPSysGravityModifier.h"
%include "obj/NiPSysGravityStrengthCtlr.h"
%include "obj/NiPSysGrowFadeModifier.h"
%include "obj/NiPSysMeshEmitter.h"
%include "obj/NiPSysMeshUpdateModifier.h"
%include "obj/NiPSysModifierActiveCtlr.h"
%include "obj/NiPSysPlanarCollider.h"
%include "obj/NiPSysPositionModifier.h"
%include "obj/NiPSysResetOnLoopCtlr.h"
%include "obj/NiPSysRotationModifier.h"
%include "obj/NiPSysSpawnModifier.h"
%include "obj/NiPSysSphereEmitter.h"
%include "obj/NiPSysUpdateCtlr.h"
%include "obj/NiRangeLODData.h"
%include "obj/NiRotatingParticles.h"
%include "obj/NiRotatingParticlesData.h"
%include "obj/NiScreenLODData.h"
%include "obj/NiSequenceStreamHelper.h"
%include "obj/NiShadeProperty.h"
%include "obj/NiSkinData.h"
%include "obj/NiSkinInstance.h"
%include "obj/NiSkinPartition.h"
%include "obj/NiSourceTexture.h"
%include "obj/NiSpecularProperty.h"
%include "obj/NiSphericalCollider.h"
%include "obj/NiSpotLight.h"
%include "obj/NiStencilProperty.h"
%include "obj/NiStringExtraData.h"
%include "obj/NiStringPalette.h"
%include "obj/NiStringsExtraData.h"
%include "obj/NiTextKeyExtraData.h"
%include "obj/NiTextureEffect.h"
%include "obj/NiTextureTransformController.h"
%include "obj/NiTexturingProperty.h"
%include "obj/NiTransformController.h"
%include "obj/NiTransformData.h"
%include "obj/NiTransformInterpolator.h"
%include "obj/NiTriShape.h"
%include "obj/NiTriShapeData.h"
%include "obj/NiTriStrips.h"
%include "obj/NiTriStripsData.h"
%include "obj/NiUVController.h"
%include "obj/NiUVData.h"
%include "obj/NiVectorExtraData.h"
%include "obj/NiVertexColorProperty.h"
%include "obj/NiVertWeightsExtraData.h"
%include "obj/NiVisController.h"
%include "obj/NiVisData.h"
%include "obj/NiWireframeProperty.h"
%include "obj/NiZBufferProperty.h"
%include "obj/RootCollisionNode.h"

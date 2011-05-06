//#org from SiegeLord
//http://ideone.com/2vZdN
//its a DMD 1.0 one, haven't been able to get it to work with D 2.0

template ArrayType(T)
{
        const ArrayType = is(typeof(T[0])) && is(typeof(T.length));
}
 
template BinaryOp(string op, string fn_name)
{
        const BinaryOp = 
        `
        BinaryExpressionType!("` ~ op ~ `", T, typeof(*this), ValT) ` ~ fn_name ~ `(ValT)(ValT other)
        {
                return BinaryExpressionType!("` ~ op ~ `", T, typeof(*this), ValT)(*this, other);
        }
        `;
}
 
template BinaryOpR(string op, string fn_name)
{
        const BinaryOpR =
        `
        BinaryExpressionType!("` ~ op ~ `", T, ValT, typeof(*this)) ` ~ fn_name ~ `(ValT : T)(ValT other)
        {
                return BinaryExpressionType!("` ~ op ~ `", T, ValT, typeof(*this))(other, *this);
        }
        `;
}
 
template ExpressionOps()
{
        mixin(BinaryOp!("+", "opAdd"));
        mixin(BinaryOp!("-", "opSub"));
        mixin(BinaryOp!("*", "opMul"));
        mixin(BinaryOp!("/", "opDiv"));
        
        mixin(BinaryOpR!("-", "opSub_r"));
        mixin(BinaryOpR!("/", "opDiv_r"));
}
 
/* Workabout for a bug in recursive template instantiation detection */
template BinaryExpressionType(char[] op, T, LHS_t, RHS_t)
{
        typedef BinaryExpression!(op, T, LHS_t, RHS_t) BinaryExpressionType;
}
 
struct BinaryExpression(char[] op, T, LHS_t, RHS_t)
{
        T opIndex(size_t idx)
        {
                const lhs_idx = ArrayType!(LHS_t);
                const rhs_idx = ArrayType!(RHS_t);
                
                static if(lhs_idx && rhs_idx)
                {
                        mixin("return LHS[idx] " ~ op ~ " RHS[idx];");
                }
                else static if(lhs_idx)
                {
                        mixin("return LHS[idx] " ~ op ~ " RHS;");
                }
                else static if(rhs_idx)
                {
                        mixin("return LHS " ~ op ~ " RHS[idx];");
                }
                else
                {
                        mixin("return LHS " ~ op ~ " RHS;");
                }
        }
        
        mixin ExpressionOps;
        
        size_t length()
        {
                const lhs_idx = ArrayType!(LHS_t);
                const rhs_idx = ArrayType!(RHS_t);
                
                static if(lhs_idx)
                {
                        mixin("return LHS.length;");
                }
                else static if(rhs_idx)
                {
                        mixin("return RHS.length;");
                }
                else
                {
                        mixin("return 0;");
                }
        }
        
        LHS_t LHS;
        RHS_t RHS;
}
 
struct Vector(T)
{
        mixin ExpressionOps;
        
        T opIndex(size_t idx)
        {
                return Data[idx];
        }
        
        T opIndexAssign(T val, size_t idx)
        {
                return Data[idx] = val;
        }
        
        Vector opAssign(ValT)(ValT other)
        {
                static if(ArrayType!(ValT))
                {
                        assert(length == other.length, "Incompatible vector lengths.");
                        foreach(idx, ref val; Data)
                        {
                                val = other[idx];
                        }
                }
                else
                {
                        Data[] = other;
                }
                
                return *this;
        }
        
        size_t length()
        {
                return Data.length;
        }
        
        void length(size_t len)
        {
                Data.length = len;
        }
        
        T[] Data;
}
 
void main()
{
        Vector!(double) a;
        
        a.length = 3;
        
        a[0] = 1;
        a[1] = 2;
        a[2] = 3;
        
        1 - a;
        a - a;
        a - 1;
}

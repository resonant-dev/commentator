import type { CommentType } from '../types/comments';
import { classNames } from '../utils/style';

type Props = {
    first: boolean;
    comment: CommentType;
};

const Comment = ({
    first,
    comment: {
        id,
        attributes: { text, html },
    },
}: Props) => {
    return (
        <div key={id} className="flex text-sm text-gray-500 space-x-4">
            <div className="flex-none py-10">
                {/* <img src={avatarSrc} alt="" className="w-10 h-10 bg-gray-100 rounded-full" /> */}
            </div>
            <div className={classNames(first ? '' : 'border-t border-gray-200', 'flex-1 py-10')}>
                {/* <h3 className="font-medium text-gray-900">{user}</h3> */}
                <p>{/* <time dateTime={datetime}>{date}</time> */}</p>

                <div
                    className="mt-4 prose prose-sm max-w-none text-gray-500"
                    // eslint-disable-next-line react/no-danger
                    dangerouslySetInnerHTML={{ __html: text /*html*/ }}
                />
            </div>
        </div>
    );
};

export default Comment;
